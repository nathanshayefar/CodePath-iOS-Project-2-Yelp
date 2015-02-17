//
//  FilterViewController.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate : class {
    func didChangeFilters(filtersViewController: FiltersViewController, filters: NSDictionary)
}

class FiltersViewController: UIViewController {
    weak var delegate: FiltersViewControllerDelegate?
    var filters = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onCancelButton")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .Plain, target: self, action: "onApplyButton")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCancelButton() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onApplyButton() {
        self.delegate!.didChangeFilters(self, filters: self.filters)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
