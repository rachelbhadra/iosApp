//
//  GroupsTableViewCell.swift
//  ShopSync
//
//  Created by Rachel Bhadra on 4/15/18.
//  Copyright © 2018 Rachel Bhadra. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
