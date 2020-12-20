//
//  TableViewCell.swift
//  MemoPad
//
//  Created by Kazuma Adachi on 2020/10/04.
//  Copyright © 2020 Kazuma Adachi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

     @IBOutlet weak var titleLabel: UILabel!
     @IBOutlet weak var favorateButton: UIButton!
        
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
