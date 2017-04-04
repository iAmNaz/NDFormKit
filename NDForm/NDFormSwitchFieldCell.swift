//
//  NDFormSwitchFieldCell.swift
//  NDForm
//
//  Created by iAmNaz on 12/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit
import NDFormKit

class NDFormSwitchFieldCell: NDFormTableViewCell {

    @IBOutlet weak var switchButton: UISwitch!
    
    @IBAction func didSwitch(_ sender: AnyObject) {
        self.fieldData().setValue(switchButton.isOn as AnyObject)
        displayBoolState()
    }
    
    override func setDisplayValue(_ forObject: NDDataWrapper) {
        displayBoolState()
    }
    
    func displayBoolState() {
        if let switched = fieldData().value() as? Bool {
            if switched {
                titleLabel.text = fieldData().fieldTitle + "\("(ON)")"
                
            }else{
                titleLabel.text = fieldData().fieldTitle + "\("(OFF)")"
            }
            switchButton.isOn = switched
        }else{
            titleLabel.text = fieldData().fieldTitle + "\("(OFF)")"
            switchButton.isOn = false
        }
    }
}
