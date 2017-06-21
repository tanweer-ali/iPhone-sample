//
//  FileUtility.swift
//  SampleApp
//
//  Created by tanweer ali on 21/06/2017.
//  Copyright © 2017 Render6D. All rights reserved.
//

import Foundation

class Utility{

    static func readFile()->String{
        var text = ""
        do{
            let path = Bundle.main.path(forResource: "issues", ofType: "csv")
            text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        }catch {
            print("Failed to read text from file")
        }
        return text
    }
    
    static func split(text: String , char:Character)->Array<String>{
        let lines = text.characters.split { $0 == char }.map(String.init)
        return lines
    }

}
