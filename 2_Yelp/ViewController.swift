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
    
    let yelpConsumerKey = "qFUBisCevpAq0mCYi_jb-g"
    let yelpConsumerSecret = "cpdvTTFI3Psrzc_hHYctqP7Rmf8"
    let yelpToken = "-kITS5YkJnKAspM2qmzyarwsDY2ihiYQ"
    let yelpTokenSecret = "SDrwzp8SUqdxzEJGpCAcBxK9ds4"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!,
                response: AnyObject!) -> Void in
                println(response)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println (error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

