//
//  NDFormSwitchFieldCell.swift
//  NDForm
//
//  Created by Jun MeAol on 12/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit
import NDFormKit

class NDFormSwitchFieldCell: NDFormTableViewCell {

    @IBOutlet weak var switchButton: UISwitch!
    
    @IBAction func didSwitch(sender: AnyObject) {
        self.fieldData().setValue(switchButton.on)
        displayBoolState()
    }
    
    override func setDisplayValue(forObject: NDDataWrapper) {
        displayBoolState()
    }
    
    func displayBoolState() {
        if let switched = fieldData().value() as? Bool {
            if switched {
                titleLabel.text = fieldData().fieldTitle + "\("(ON)")"
                
            }else{
                titleLabel.text = fieldData().fieldTitle + "\("(OFF)")"
            }
            switchButton.on = switched
        }else{
            titleLabel.text = fieldData().fieldTitle + "\("(OFF)")"
            switchButton.on = false
        }
    }
}
