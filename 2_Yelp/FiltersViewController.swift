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

enum FilterSection : Int, Printable {
    case Categories, Sort, Distance, Deals
    
    var description : String {
        get {
            switch self {
            case .Categories:
                return "Categories"
            case .Sort:
                return "Sort by"
            case .Distance:
                return "Distance"
            case .Deals:
                return "Deals"
            }
        }
    }
    
    // A little hacky; I still need to dig deeper into Swift enums
    static let values = [Categories, Sort, Distance, Deals]
    static let count = values.count
    
    // Not fault tolerant
    static func fromValue(index: Int) -> FilterSection {
        return values[index]
    }
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, SegmentCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "SwitchCell")
        self.tableView.registerNib(UINib(nibName: "SegmentCell", bundle: nil), forCellReuseIdentifier: "SegmentCell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onCancelButton")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: "onSearchButton")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return FilterSection.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FilterSection.fromValue(section).description
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case FilterSection.Categories.rawValue:
            return Filter.count()
        case FilterSection.Sort.rawValue, FilterSection.Distance.rawValue, FilterSection.Deals.rawValue:
                return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case FilterSection.Categories.rawValue:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("SwitchCell") as SwitchCell
                
            cell.delegate = self
            cell.titleLabel.text = Filter.getName(indexPath)
            cell.setSwitchValue(Filter.isEnabledCategory(indexPath))
                
            return cell
            
        case FilterSection.Sort.rawValue:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("SegmentCell") as SegmentCell
            
            cell.delegate = self
            cell.titleLabel.text = "Sort by"
            cell.type = FilterSection.Sort
            cell.setSegmentValue(Filter.sortValue())
            cell.toggleSegment.setTitle("Best Match", forSegmentAtIndex: 0)
            cell.toggleSegment.setTitle("Distance", forSegmentAtIndex: 1)
            cell.toggleSegment.setTitle("Rating", forSegmentAtIndex: 2)
            return cell
        
        case FilterSection.Distance.rawValue:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("SegmentCell") as SegmentCell
            
            cell.delegate = self
            cell.titleLabel.text = "Distance"
            cell.type = FilterSection.Distance
            cell.setSegmentValue(Filter.distanceValue())
            cell.toggleSegment.setTitle("1km", forSegmentAtIndex: 0)
            cell.toggleSegment.setTitle("2km", forSegmentAtIndex: 1)
            cell.toggleSegment.setTitle("5km", forSegmentAtIndex: 2)
            return cell
        
        case FilterSection.Deals.rawValue:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("SwitchCell") as SwitchCell
            
            cell.delegate = self
            cell.titleLabel.text = "Offering a Deal"
            cell.setSwitchValue(Filter.dealsEnabled())
            return cell
        
        default:
            return UITableViewCell()
        }
    }
    
    func didUpdateValue(switchCell: SwitchCell, value: Bool) {
        let indexPath = self.tableView.indexPathForCell(switchCell)!
        Filter.enableCategory(indexPath, enable: value)
    }
    
    func didUpdateSegment(segmentCell: SegmentCell, index: Int) {
        let indexPath = self.tableView.indexPathForCell(segmentCell)
        let type = segmentCell.type!
        
        if (type == FilterSection.Sort) {
            Filter.setSort(index)
        } else if (type == FilterSection.Distance) {
            Filter.setDistance(index)
        }
    }
    
    func onCancelButton() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func onSearchButton() {
        self.delegate!.didChangeFilters(self, filters: Filter.getFilters())
        self.navigationController?.popViewControllerAnimated(true)
    }
}
