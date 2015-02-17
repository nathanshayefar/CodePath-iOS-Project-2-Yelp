//
//  Filter.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

struct Filter {
    // A subset of all the available Yelp categories
    private static let categories = [
        ["name" : "American, New", "code": "newamerican"],
        ["name" : "Persian/Iranian", "code": "persian"],
        ["name" : "Sandwiches", "code": "sandwiches"],
        ["name" : "Soup", "code": "soup"],
        ["name" : "Vegan", "code": "vegan"]
    ]
    
    private static var filters: [String : String] = [:]
    // Swift sets don't exist in Xcode 8.2, so we use a Dictionary instead.
    private static var selectedCategories: [NSDictionary: Bool] = [:]
    
    static func getName(row: Int) -> String {
        return self.categories[row]["name"]! as String
    }
    
    static func getCode(row: Int) -> String {
        return self.categories[row]["code"]! as String
    }
    
    static func isEnabled(row: Int) -> Bool {
        let selectedKey = self.categories[row]
        return self.selectedCategories[selectedKey] == true
    }
    
    static func enable(row: Int, enable: Bool) {
        let selectedKey = self.categories[row]
        
        if (enable) {
            self.selectedCategories[selectedKey] = true
        } else {
            self.selectedCategories.removeValueForKey(selectedKey)
        }
    }
    
    static func getFilters() -> [String : String] {
        return self.filters
    }
    
    static func count() -> Int {
        return self.categories.count
    }
}
