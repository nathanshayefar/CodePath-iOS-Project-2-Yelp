//
//  ViewController.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/9/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var client: YelpClient!
    var businesses: [Business] = []
    
    let yelpConsumerKey = "qFUBisCevpAq0mCYi_jb-g"
    let yelpConsumerSecret = "cpdvTTFI3Psrzc_hHYctqP7Rmf8"
    let yelpToken = "-kITS5YkJnKAspM2qmzyarwsDY2ihiYQ"
    let yelpTokenSecret = "SDrwzp8SUqdxzEJGpCAcBxK9ds4"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let responseDictionary = response as NSDictionary
                let responseBusinesses = responseDictionary["businesses"] as [NSDictionary]
            
                self.businesses = Business.businessesFromDictionaries(responseBusinesses)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println (error)
        }
    }
}

