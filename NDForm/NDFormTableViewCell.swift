//
//  BaseSimpleTableViewCell.swift
//  NuMe-Microbiology
//
//  Created by JMariano on 6/27/15.
//  Copyright (c) 2015 Portable Genomics. All rights reserved.
//

import UIKit
import NDFormKit

open class NDFormTableViewCell: UITableViewCell {
    fileprivate var _fieldData: NDDataWrapper!
    @IBOutlet weak var titleLabel: UILabel!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func onCellDisplay() {
        
    }
    
    open func setDisplayValue(_ forObject: NDDataWrapper) {
        
    }
    
    open func setFieldData(_ simpleData: NDDataWrapper) {
        _fieldData = simpleData
    }
    
    open func fieldData() -> NDDataWrapper {
        return _fieldData
    }
}
