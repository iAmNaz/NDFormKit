//
//  NDFormTextFieldCell.swift
//  NDForm
//
//  Created by iAmNaz on 05/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit
import NDFormKit

class NDFormTextFieldCell: NDFormTableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    func textFieldBegunEditing(_ textField: UITextField) {
        titleLabel.textColor = titleLabel.tintColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleLabel.textColor = UIColor.black
        
        let text = textField.text
        
        if text!.isEmpty {
            titleLabel.textColor = UIColor.red
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func isChangingText(_ sender: AnyObject) {
        let text = textField.text
        
        if text!.isEmpty {
            self.fieldData().setValue(nil)
        }else{
            self.fieldData().setValue(text as AnyObject)
        }
        //replace with delegate pattern

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setDisplayValue(_ forObject: NDDataWrapper) {
        self.textField.text = forObject.displayText()
    }
}
