//
//  ReviewTVCell.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/30/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class ReviewTVCell: UITableViewCell {

    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
