//
//  BlockTableViewCell.swift
//  Glancer
//
//  Created by Cassandra Kane on 11/29/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import UIKit

class BlockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var blockLetter: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classTimes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    ///hi
    
}
