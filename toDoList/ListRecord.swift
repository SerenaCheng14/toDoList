//
//  ListRecord.swift
//  toDoList
//
//  Created by Serena on 2021/1/22.
//

import Foundation


struct ResponseData: Codable {
    let records: [Record]
    
    
    struct Record: Codable {
//        let id: String?
        let fields: Field
    }
    
    struct Field: Codable {
        let complete: String
        let note: String?
        let title: String
        let deadline: String
        let priority: String

        
    }
    
}
