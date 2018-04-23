//
//  ListTableViewController.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/17/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit

class ListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listName: UILabel!
    var listID = Int()
    var listItems = [String]()
    let cellHeight:CGFloat = 50

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.listTableView.separatorColor = UIColor.white
        listItems = lists[listID]
        listName.text = groups[listID]
        listTableView.delegate = self
        listTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ListTableViewCell {
            cell.itemLabel.text = listItems[indexPath.row]
            if checked[listID][indexPath.row] {
                cell.checkbox.setImage(UIImage(named: "checked"), for: .normal)
            } else {
                cell.checkbox.setImage(UIImage(named: "unchecked"), for: .normal)
            }
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
        listTableView.deselectRow(at: indexPath, animated: false)
        let curr = checked[listID][indexPath.row]
        checked[listID][indexPath.row] = !curr
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
