//
//  CurrentUser.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/28/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class CurrentUser {
    
    var username: String!
    var id: String!
    var listIDs: [String]?
    
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
    }
    
    
    
    func getListIDs(completion: @escaping ([String]) -> Void) {
        var listArray: [String] = []
        let dbRef = Database.database().reference()
        dbRef.child(firListsNode).observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let lists = snapshot.value as? [String:AnyObject] {
                    for key in lists.keys {
                        if let listID = lists[key]!["id"] as? String{
                            listArray.append(listID )
                        }
                    }
                }
            }
            completion(listArray)
        })
    }
    
    
    func addListID(listID: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let key = ref.child(firListsNode).childByAutoId().key
        let childUpdate = ["/" + firListsNode + "/\(key)": listID]
        ref.updateChildValues(childUpdate)
    }
    
    func addList(list: List) {
        let dbRef = Database.database().reference()
        
        let listDict: [String:AnyObject] = ["id": list.listId as AnyObject,
                                            "name": list.name as AnyObject,
                                            "members": list.members as AnyObject,
                                            "items": list.items as AnyObject,
                                            "checked": list.checked as AnyObject]
        let key = dbRef.child(firListsNode).childByAutoId().key
        let childUpdate = ["/" + firListsNode + "/\(key)": listDict]
        dbRef.updateChildValues(childUpdate)
    }
    
    func updateName(id: String, name: String) {
        let dbRef = Database.database().reference().child("/" + firListsNode + "/\(id)")
        dbRef.updateChildValues([
            "name": name
            ])
    }
    
    func updateMembers(id: String, members: [String]) {
        let dbRef = Database.database().reference().child("/" + firListsNode + "/\(id)")
        dbRef.updateChildValues([
            "members": members
            ])
    }
    
    func updateItems(id: String, items: [String]) {
        let dbRef = Database.database().reference().child("/" + firListsNode + "/\(id)")
        dbRef.updateChildValues([
        "items": items
        ])
    }
    
    func updateChecked(id: String, checked: [Bool]) {
        let dbRef = Database.database().reference().child("/" + firListsNode + "/\(id)")
        dbRef.updateChildValues([
            "checked": checked
            ])
    }
    

    
}
