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
    
    @IBOutlet weak var totalLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteBtnPressed(_ sender: Any) {
    }
    override func layoutSubviews() {
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.cornerRadius = BUTTONCORNERRADIUS
        self.clipsToBounds = false
    }
}
