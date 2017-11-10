//
//  ProductTVCell.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class ProductTVCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    static let reuseIdentifier = "ProductTVCell-ID"
    static let xibName = "ProductTVCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
