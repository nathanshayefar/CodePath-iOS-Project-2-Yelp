//
//  ViewController.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/9/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var client: YelpClient!
    var businesses: [Business] = []
    
    let yelpConsumerKey = "qFUBisCevpAq0mCYi_jb-g"
    let yelpConsumerSecret = "cpdvTTFI3Psrzc_hHYctqP7Rmf8"
    let yelpToken = "-kITS5YkJnKAspM2qmzyarwsDY2ihiYQ"
    let yelpTokenSecret = "SDrwzp8SUqdxzEJGpCAcBxK9ds4"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Yelp"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "BusinessCell")
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let responseDictionary = response as NSDictionary
                let responseBusinesses = responseDictionary["businesses"] as [NSDictionary]
            
                println(responseBusinesses)
            
                self.businesses = Business.businessesFromDictionaries(responseBusinesses)
            
                self.tableView.reloadData()
        }) {
            (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCell
        cell.setBusiness(self.businesses[indexPath.row])
        return cell
    }
}

