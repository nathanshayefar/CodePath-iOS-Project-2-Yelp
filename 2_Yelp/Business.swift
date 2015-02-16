//
//  Business.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

struct Business {
    var imageUrl: NSURL
    var name: String
    var ratingImageUrl: NSURL
    var numberOfReviews: Int
    var address: String
    var categories: [String]
    var distance: Double
    
    static func fromDictionary(dict: NSDictionary) -> Business {
        let imageUrl = NSURL(string: "")!
        let name = ""
        let ratingImageUrl = NSURL(string: "")!
        let numberOfReviews = 0
        let address = ""
        let categories = [""]
        let distance = 0.0
        
        return Business(
            imageUrl: imageUrl,
            name: name,
            ratingImageUrl: ratingImageUrl,
            numberOfReviews: numberOfReviews,
            address: address,
            categories: categories,
            distance: distance
        )
    }

    static func businessesFromDictionaries(dicts: [NSDictionary]) -> [Business] {
        var businesses: [Business] = []
        
        for dict in dicts {
            businesses.append(Business.fromDictionary(dict))
        }

        return businesses
    }
}
