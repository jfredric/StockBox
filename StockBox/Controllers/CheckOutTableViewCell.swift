//
//  CheckOutTableViewCell.swift
//  StockBox
//
//  Created by Jared Sobol on 11/2/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class CheckOutTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBOutlet weak var quantityNum: UITextField!
    
    @IBOutlet weak var totalLBl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
