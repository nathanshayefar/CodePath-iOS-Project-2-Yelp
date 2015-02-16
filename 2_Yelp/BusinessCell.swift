//
//  BusinessCell.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusiness(business: Business) {
        self.thumbnailImageView.setImageWithURL(business.imageUrl)
        self.nameLabel.text = business.name
        self.ratingImageView.setImageWithURL(business.ratingImageUrl)
        self.ratingLabel.text = "\(business.numberOfReviews) Reviews"
        self.addressLabel.text = business.address
        self.distanceLabel.text = String(format: "%.2f mi", business.distance)
        self.categoryLabel.text = business.categories
    }
}
