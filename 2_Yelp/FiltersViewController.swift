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

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "SwitchCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onCancelButton")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: "onSearchButton")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Filter.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SwitchCell") as SwitchCell
        
        cell.delegate = self
        cell.titleLabel.text = Filter.getName(indexPath.row)
        cell.setSwitchValue(Filter.isEnabled(indexPath.row))
        
        return cell
    }
    
    func didUpdateValue(switchCell: SwitchCell, value: Bool) {
        let indexPath = self.tableView.indexPathForCell(switchCell)!
        Filter.enable(indexPath.row, enable: value)
    }
    
    func onCancelButton() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onSearchButton() {
        self.delegate!.didChangeFilters(self, filters: Filter.getFilters())
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
