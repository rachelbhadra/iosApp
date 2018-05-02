//
//  ListTableViewController.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/17/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit
import FirebaseAuth

class ListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listName: UILabel!
    var listID = Int()
    var listItems = [String]()
    let cellHeight:CGFloat = 55

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.listTableView.separatorColor = UIColor.white
        listName.text = lists[listID].name
        listTableView.delegate = self
        listTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists[listID].items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ListTableViewCell {
            cell.itemLabel.text = lists[listID].items[indexPath.row]
            if lists[listID].checked[indexPath.row] {
                cell.checkbox.image = UIImage(named: "checked.png")
            } else {
                cell.checkbox.image = UIImage(named: "unchecked.png")
            }
            return cell
        }
        return UITableViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToList(_ sender: UIButton) {
        self.performSegue(withIdentifier: "listToNew", sender: self)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.listTableView.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToNew" {
            if let dest = segue.destination as? NewItemViewController {
                dest.listID = listID
                dest.prev = self
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curr = lists[listID].checked[indexPath.row]
        lists[listID].checked[indexPath.row] = !curr
        listTableView.reloadData()
    }
    

    @IBAction func completeAll(_ sender: Any) {
        for i in 0...(lists[listID].items.count - 1) {
            if !lists[listID].checked[i] {
                lists[listID].checked[i] = true
            }
        }
        listTableView.reloadData()
    }
    
    @IBAction func clearCompleted(_ sender: Any) {
        var newList = [String]()
        var newChecked = [Bool]()
        for i in 0...(lists[listID].items.count - 1) {
            if !lists[listID].checked[i] {
                newList.append(lists[listID].items[i])
                newChecked.append(lists[listID].checked[i])
            }
        }
        lists[listID].items = newList
        lists[listID].checked = newChecked
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            lists[self.listID].items.remove(at: indexPath.row)
            self.listTableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = UIColor.lightGray
        
        return [delete]
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "listToLogin", sender: self)
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
