//
//  RssCell.swift
//  CodeChallenge
//
//  Created by Mohammed Ragab on 9/10/16.
//  Copyright © 2016 MasterWorks. All rights reserved.
//

import UIKit

class RssCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
//    @IBOutlet weak var imgV_image: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
