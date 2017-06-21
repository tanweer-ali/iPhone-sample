//
//  IssueTableViewController.swift
//  SampleApp
//
//  Created by tanweer ali on 20/06/2017.
//  Copyright © 2017 Render6D. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IssueTableViewController: UITableViewController {
    
    var issues  = Array<Issue>()
    
    func onDataLoaded(element:Array<Issue>)->Void{
        self.issues = element
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Issue.loadData( onDataLoaded )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\(issues[indexPath.row].firstName) \(issues[indexPath.row].lastName)"

        return cell
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Issues in File"
    }
    
}
