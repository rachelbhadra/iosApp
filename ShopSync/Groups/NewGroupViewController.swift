//
//  NewGroupViewController.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/17/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var popup: UIView!
    var prev = GroupsTableViewController()
    let currentUser = CurrentUser()
    
    let sendAlert = UIAlertController(title: "New list created!", message: "", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.text = ""
        popup.layer.cornerRadius = 10;
        popup.layer.masksToBounds = true;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func create(_ sender: Any) {
        if nameText.text != "" {
            let name = nameText.text!
            let members = ["Me"]
            let items = [String]()
            let checked = [Bool]()
            let key = currentUser.addList(name: name, members: members, items: items, checked: checked)
            let list = List(id: key, name: name, items: items, members: members, checked: checked)
            addToLists(list: list)
            currentUser.addListID(listID: key)
            self.present(sendAlert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.sendAlert.dismiss(animated: false, completion: nil)
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        prev.groupsTableView.reloadData()
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
