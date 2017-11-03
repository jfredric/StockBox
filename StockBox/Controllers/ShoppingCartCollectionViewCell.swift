//
//  ShoppingCartCollectionViewCell.swift
//  StockBox
//
//  Created by Jared Sobol on 11/2/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class ShoppingCartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var verderName: UILabel!
    @IBOutlet weak var venderLocation: UILabel!
    
    @IBOutlet weak var numOfProducts: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
