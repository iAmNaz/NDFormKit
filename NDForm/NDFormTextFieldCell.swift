//
//  NDFormTextFieldCell.swift
//  NDForm
//
//  Created by Jun MeAol on 05/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit
import NDFormKit

class NDFormTextFieldCell: NDFormTableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    func textFieldBegunEditing(textField: UITextField) {
        titleLabel.textColor = titleLabel.tintColor
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        titleLabel.textColor = UIColor.blackColor()
        
        let text = textField.text
        
        if text!.isEmpty {
            titleLabel.textColor = UIColor.redColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func isChangingText(sender: AnyObject) {
        let text = textField.text
        
        if text!.isEmpty {
            self.fieldData().setValue(nil)
        }else{
            self.fieldData().setValue(text)
        }
        //replace with delegate pattern

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setDisplayValue(forObject: NDDataWrapper) {
        self.textField.text = forObject.displayText()
    }
}
