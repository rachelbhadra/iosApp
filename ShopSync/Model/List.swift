//
//  List.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 5/1/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import Foundation
import UIKit

class List {
    
    /// List name
    var name: String
    
    /// Items in the list
    var items: [String]
    
    /// Members who can access this list
    let members: [String]
    
    /// Boolean array indicating whether items have been checked
    var checked: [Bool]
    
    /// The ID of the list
    let id: String
    
    

    init(id: String, name: String, items: [String], members: [String], checked: [Bool]) {
        self.name = name
        self.items = items
        self.members = members
        self.checked = checked
        self.id = id
    }
}
