//
//  DataItem.swift
//  SwiftDataDemo
//
//  Created by 석민솔 on 4/15/25.
//

import Foundation
import SwiftData

@Model
class DataItem:Identifiable {
    
    var id: String
    var name: String
    
    init(name: String) {
        
        self.id = UUID().uuidString
        self.name = name
    }
}
