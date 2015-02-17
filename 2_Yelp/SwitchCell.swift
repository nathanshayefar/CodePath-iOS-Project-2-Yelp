//
//  SwitchCell.swift
//  2_Yelp
//
//  Created by Nathan Shayefar on 2/16/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate : class {
    func didUpdateValue(switchCell: SwitchCell, value: Bool)
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSwitchValueAnimated(value: Bool, animated: Bool) {
        toggleSwitch.setOn(value, animated: animated)
    }
    
    func setSwitchValue(value: Bool) {
        setSwitchValueAnimated(value, animated: false)
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate!.didUpdateValue(self, value: toggleSwitch.on)
    }
}
