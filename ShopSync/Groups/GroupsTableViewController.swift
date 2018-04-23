//
//  GroupsTableViewController.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/17/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit

class GroupsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupsTableView: UITableView!
    var selectedList = Int()
    
    let cellHeight:CGFloat = 65
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupsTableView.separatorColor = UIColor.white
        groupsTableView.delegate = self
        groupsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsTableViewCell {
            cell.listLabel.text = groups[indexPath.row]
            cell.membersLabel.text = ""
//            let backgroundView = UIView()
//            backgroundView.backgroundColor = UIColor(red:0.62, green:0.38, blue:0.49, alpha:1.0)
//            cell.selectedBackgroundView = backgroundView
            
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.groupsTableView.reloadData()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedList = indexPath.row
        groupsTableView.deselectRow(at: indexPath, animated: false)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
