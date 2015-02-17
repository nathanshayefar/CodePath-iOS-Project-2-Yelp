//
//  Filter.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

struct Filter {
    // Swift sets don't exist in Xcode 8.2, so we use a Dictionary instead.
    private static var selectedCategories: [NSDictionary : Bool] = [:]
    // A subset of all the available Yelp categories
    private static let categories = [
        ["name" : "American, New", "code": "newamerican"],
        ["name" : "Persian/Iranian", "code": "persian"],
        ["name" : "Sandwiches", "code": "sandwiches"],
        ["name" : "Soup", "code": "soup"],
        ["name" : "Vegan", "code": "vegan"]
    ]
    
    private static var filters: [String : NSObject] =
        ["deals" : false]
    
    static func getName(indexPath: NSIndexPath) -> String {
        return self.categories[indexPath.row]["name"]! as String
    }
    
    static func getCode(indexPath: NSIndexPath) -> String {
        return self.categories[indexPath.row]["code"]! as String
    }
    
    static func isEnabledCategory(indexPath: NSIndexPath) -> Bool {
        let selectedKey = self.categories[indexPath.row]
        return self.selectedCategories[selectedKey] == true
    }
    
    static func enableCategory(indexPath: NSIndexPath, enable: Bool) {
        // This deserves to have its own method, but I wasn't able to wrangle the data there
        if (indexPath.section == FilterSection.Deals.rawValue) {
            self.setDeals(enable)
        }
        
        if (indexPath.section != FilterSection.Categories.rawValue) {
            return
        }
        
        let selectedKey = self.categories[indexPath.row]
        
        if (enable) {
            self.selectedCategories[selectedKey] = true
        } else {
            self.selectedCategories.removeValueForKey(selectedKey)
        }
        
        self.filters["categories"] = self.selectedCategoryNames()
    }
    
    static func dealsEnabled() -> Bool {
        return filters["deals"]! as Bool
    }
    
    static func setDeals(value: Bool) {
        filters["deals"] = value
    }
    
    static func getFilters() -> [String : NSObject] {
        return self.filters
    }
    
    static func count() -> Int {
        return self.categories.count
    }
    
    private static func selectedCategoryNames() -> String {
        var categoryCodes: [String] = []
        
        for (category, found) in self.selectedCategories {
            if found {
                let categoryCode = (category as NSDictionary)["code"] as String
                categoryCodes.append(categoryCode)
            }
        }
        
        return ",".join(categoryCodes)
    }
}
