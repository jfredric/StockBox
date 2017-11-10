//
//  VenderProductDetailCVCell.swift
//  StockBox
//
//  Created by Jared Sobol on 11/7/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class VenderProductDetailCVCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    override func layoutSubviews() {
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.cornerRadius = 30
        self.clipsToBounds = true
    }
}
