//
//  SegmentCell.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

protocol SegmentCellDelegate : class {
    func didUpdateSegment(segmentCell: SegmentCell, index: Int)
}

class SegmentCell: UITableViewCell {
    var type: FilterSection?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleSegment: UISegmentedControl!
    
    weak var delegate: SegmentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSegmentValue(index: Int) {
        toggleSegment.selectedSegmentIndex = index
    }
    
    @IBAction func segmentValueChanged(sender: AnyObject) {
        delegate!.didUpdateSegment(self, index: toggleSegment.selectedSegmentIndex)
    }
}