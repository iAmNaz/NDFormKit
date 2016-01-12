//
//  BaseSimpleTableViewCell.swift
//  NuMe-Microbiology
//
//  Created by JMariano on 6/27/15.
//  Copyright (c) 2015 Portable Genomics. All rights reserved.
//

import UIKit
import NDFormKit

public class NDFormTableViewCell: UITableViewCell {
    private var _fieldData: NDDataWrapper!
    @IBOutlet weak var titleLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func onCellDisplay() {
        
    }
    
    public func setDisplayValue(forObject: NDDataWrapper) {
        
    }
    
    public func setFieldData(simpleData: NDDataWrapper) {
        _fieldData = simpleData
    }
    
    public func fieldData() -> NDDataWrapper {
        return _fieldData
    }
}
