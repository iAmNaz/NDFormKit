//
//  ValueToStringTransformer.swift
//  NDForm
//
//  Created by iAmNaz on 11/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit
import NDFormKit

class ValueToStringTransformer: NSObject, NDValueToStringTransformer {
    func toString(value: AnyObject?) -> String {
        if value != nil {
            return value as! String
        }else{
            return ""
        }
    }
}
