//
//  Globals.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/18/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

var lists = [List]()

let firUsersNode = "Users"
let firListsNode = "lists"
let firUsernameNode = "username"

func addToLists(list: List) {
    lists.append(list)
}

func clearLists() {
    lists = []
}

func getLists(user: CurrentUser, completion: @escaping ([List]?) -> Void) {
    let dbRef = Database.database().reference()
    var listArray: [List] = []
    dbRef.child(firListsNode).observeSingleEvent(of: .value, with: { snapshot -> Void in
        if snapshot.exists() {
            if let lists = snapshot.value as? [String:AnyObject] {
                user.getListIDs(completion: { (ids) in
                    for listKey in lists.keys {
                        if ids.contains(listKey) {
                            let listVal = lists[listKey] as! [String:AnyObject]
                            var items = [String]()
                            var checked = [Bool]()
                            if listVal["items"] != nil {
                                items = listVal["items"]! as! [String]
                            }
                            if listVal["checked"] != nil {
                                checked = listVal["checked"]! as! [Bool]
                            }
                            let list = List(id: listKey, name: listVal["name"] as! String, items: items, members: listVal["members"]! as! [String], checked: checked)
                            listArray.append(list)
                        }
                    }
                    completion(listArray)
                })
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    })
}
