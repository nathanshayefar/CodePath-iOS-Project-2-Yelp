//
//  YelpClient.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

// Source: Codepath Yelp starter project (https://github.com/codepath/ios_yelp_swift)
class YelpClient: BDBOAuth1RequestOperationManager {
    let latitude = "37.774866"
    let longitude = "-122.394556"
    
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    // Passing the Filter dict is too messy. Clean up.
    func searchWithFilter(filter: NSDictionary, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        var parameters: [String : String] = [:]
        
        parameters["term"] = "Thai"
        parameters["ll"] = "\(latitude),\(longitude)"
        
        if let category_filter = filter["categories"] as? String {
            if !category_filter.isEmpty {
                parameters["category_filter"] = category_filter
            }
        }
        
        if let deals_filter = filter["deals"] as? Bool {
            parameters["deals_filter"] = deals_filter ? "1" : "0"
        }
        
        if let distance = filter["distance"] as? Int {
            if distance > 0 {
                parameters["radius_filter"] = String(distance * 1000)
            }
        }
        
        if let sort = filter["sort"] as? Int {
            parameters["sort"] = String(sort)
        }
        
        println(parameters)
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}
