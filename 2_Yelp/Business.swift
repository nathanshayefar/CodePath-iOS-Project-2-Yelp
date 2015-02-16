//
//  Business.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

struct Business {
    let imageUrl: NSURL
    let name: String
    let ratingImageUrl: NSURL
    let numberOfReviews: Int
    let address: String
    let categories: [String]
    let distance: Double?
    
    static func fromDictionary(dict: NSDictionary) -> Business {
        let name = dict["name"]! as String
        
        var categories: [String] = []
        // Categories are returned as a list of lists
        let categoriesList = dict["categories"]! as [[String]]
        // TODO: de-dupe
        if !categoriesList.isEmpty {
            for categoryString in categoriesList[0] {
                categories.append(categoryString.capitalizedString)
            }
        }
        
        let imageUrlString = dict["image_url"]! as String
        let imageUrl = NSURL(string: imageUrlString)!
        
        let ratingImageUrlString = dict["rating_img_url"]! as String
        let ratingImageUrl = NSURL(string: ratingImageUrlString)!
        
        let numberOfReviews = dict["review_count"]! as Int
        
        let locationDict = dict["location"]! as NSDictionary
        let streetAddresses = locationDict["address"]! as [String]
        let neighborhoods = locationDict["neighborhoods"]! as [String]
        
        // Build an address using the first address and neighborhood, if possible
        var address: String = ""
        if (!streetAddresses.isEmpty) {
            address += "\(streetAddresses[0]), "
        }
        if (!neighborhoods.isEmpty) {
            address += neighborhoods[0]
        }
        
//        var coordinates: NSDictionary = {
//            latitude = 0.0,
//            longitude = 0.0
//        }
//        if let coordinate = locationDict["coordinate"] {
//            
//        }
        
        // May be necessary for storing business ID
//        NSString *encodedId = [businessId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
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
