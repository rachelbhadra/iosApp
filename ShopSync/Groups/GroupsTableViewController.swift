//
//  GroupsTableViewController.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/17/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit
import FirebaseAuth

class GroupsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupsTableView: UITableView!
    var selectedList = Int()
    
    let cellHeight:CGFloat = 65
    
    let currentUser = CurrentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupsTableView.separatorColor = UIColor.white
        groupsTableView.delegate = self
        groupsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsTableViewCell {
            cell.listLabel.text = lists[indexPath.row].name
            let membersString = lists[indexPath.row].members.joined(separator: ", ")
            cell.membersLabel.text = membersString
            return cell
        }
        return UITableViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createNewGroup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "groupsToCreate", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.groupsTableView.reloadData()
        //updateData()
    }
    
    func updateData() {
        getLists(user: currentUser) { (lists) in
            if let lists = lists {
                clearLists()
                for list in lists {
                    addToLists(list: list)
                }
                self.groupsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedList = indexPath.row
        performSegue(withIdentifier: "groupsToList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupsToList" {
            if let dest = segue.destination as? ListTableViewController {
                dest.listID = selectedList
            }
        }
        if segue.identifier == "groupsToCreate" {
            if let dest = segue.destination as? NewGroupViewController {
                dest.prev = self
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            lists.remove(at: indexPath.row)
            self.groupsTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
//        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
//        }
        
        delete.backgroundColor = UIColor.lightGray
        
        return [delete]
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "groupsToLogin", sender: self)
        } catch let err {
            print(err)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
