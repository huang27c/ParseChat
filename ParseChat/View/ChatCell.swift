//
//  ChatCell.swift
//  ParseChat
//
//  Created by Ching Ching Huang on 10/22/18.
//  Copyright © 2018 Ching Ching Huang. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var messages: PFObject! {
        didSet{
            messageLabel.text = messages.object(forKey: "text") as? String
            let user = messages.object(forKey:"user") as? PFUser
            let userName = user?.username
            self.userLabel.text = userName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
