//
//  IssueModal.swift
//  SampleApp
//
//  Created by tanweer ali on 21/06/2017.
//  Copyright © 2017 Render6D. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

struct Issue {
    
    var id = 0
    var firstName = ""
    var lastName = ""
    var issueCount = 0
    var dateOfBirths = Date()
}

protocol MockedIssues{
    func getMockedIssues()->Array<Issue>
}

protocol FiledIssues{
    func readIssuesFromFile()->(Array<Issue>)
}

extension Issue :FiledIssues{
    
    func readIssuesFromFile()->Array<Issue>{
        
        let text = Utility.readFile()
        var issues = [Issue]()
        
        let lines = Utility.split(text: text, char: "\r\n")
        for line in lines {
            var issue = Issue()
            let words = Utility.split(text: line, char: ",")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            issue.firstName = words[0].replacingOccurrences(of: "\"", with: "")
            issue.lastName = words[1].replacingOccurrences(of: "\"", with: "")
            issue.issueCount = Int(words[2])!
            let word = words[3].replacingOccurrences(of: "\"", with: "")
            issue.dateOfBirths = dateFormatter.date(from: word)!
            
            issues.append(issue)
        }
        
        return issues
    }
    
        
    static func loadIssuesFromFileAsObservable()-> Observable<Array<Issue>>{
        let issue = Issue()
        let observable = Observable< Array<Issue> >.create { (observer) -> Disposable in
            DispatchQueue.global(qos: .default).async {
                //Thread.sleep(forTimeInterval: 3)
                observer.onNext( issue.readIssuesFromFile() )
                observer.onCompleted()
            }
            return Disposables.create()
        }
        return observable
    }
    
    
    static func loadData( _ onDataLoaded: @escaping (Array<Issue>) -> Void  ){
        
        // Observe for data on the Ui Thread
        loadIssuesFromFileAsObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (element) in
                onDataLoaded(element)
            }).addDisposableTo(disposeBag)
    }
    
}


extension Issue : CustomStringConvertible, MockedIssues{
    
    public var description: String {
        return "Issue: \(firstName)"
    }
    
    func getMockedIssues()->Array<Issue>{
        
        var issueList = [Issue]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var issue = Issue()
        issue.id = 0
        issue.firstName = "Nikola"
        issue.lastName = "Tesla"
        issue.dateOfBirths = dateFormatter.date(from: "2014-07-15")!
        issueList.append(issue)
        
        issue.id = 1
        issue.firstName = "Edwin"
        issue.lastName = "Hubble"
        issue.dateOfBirths = dateFormatter.date(from: "1998-06-10")!
        issueList.append(issue)
        
        issue.id = 2
        issue.firstName = "John"
        issue.lastName = "von Neuman"
        issue.dateOfBirths = dateFormatter.date(from: "2002-01-09")!
        issueList.append(issue)
        
        return issueList
    }
}
