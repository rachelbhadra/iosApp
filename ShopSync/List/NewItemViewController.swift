//
//  NewItemViewController.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/18/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var itemText: UITextField!
    @IBOutlet weak var popup: UIView!
    var listID = Int()
    var prev = ListTableViewController()
    let currentUser = CurrentUser()
    
    let sendAlert = UIAlertController(title: "Item added!", message: "", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemText.text = ""
        popup.layer.cornerRadius = 10;
        popup.layer.masksToBounds = true;
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(_ sender: Any) {
        if itemText.text != "" {
            lists[listID].items.append(itemText.text!)
            let items = lists[listID].items
            lists[listID].checked.append(false)
            let checked = lists[listID].checked
            currentUser.updateItems(id: lists[listID].id, items: items)
            currentUser.updateChecked(id: lists[listID].id, checked: checked)
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
        prev.listTableView.reloadData()
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
