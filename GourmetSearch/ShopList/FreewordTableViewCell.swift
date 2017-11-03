//
//  FreewordTableViewCell.swift
//  GourmetSearch
//
//  Created by 佐藤恒 on 2017/11/01.
//  Copyright © 2017年 佐藤恒. All rights reserved.
//

import UIKit

class FreewordTableViewCell: UITableViewCell {
    @IBOutlet weak var freeword: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
