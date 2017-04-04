//
//  NDFormDataSet.swift
//  NDForm
//
//  Created by iAmNaz on 05/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit

/// This class makes it convenient to organize data for UITableViews
open class NDFormDataSet: NSObject, NSCopying {
    /**
     A multidimensional array of NDDataWrappers. The structure is synonymous to UITableView's section and rows.
    */
    open var rows:[[NDDataWrapper]]!
    /**
     Adding a new row is done on a different queue
    */
    fileprivate var dataSetQueue: DispatchQueue!
    /**
     NSMapTable can hold keys and values with weak references, in such a way that entries are removed when either the key or value is deallocated
     */
    fileprivate var objectCache:NSMapTable<AnyObject, AnyObject>!
    
    public override init() {
        super.init()
        rows = [[NDDataWrapper]]()
        objectCache = NSMapTable()
        initQueue()
    }
    
    /**
     Method for fetching a datawrapper from the cache
     
     - Parameter tag: Fetch an object using its tag
     - Returns: NDDataWrapper
    */
    open func objectWithTag(_ tag: String) -> NDDataWrapper? {
        return objectCache.object(forKey: tag as AnyObject) as? NDDataWrapper
    }
    
    /**
     A section can be added using this method
     
     - Parameter section: An array of NDDataWrapper added to the dataset
     - Returns: Void
    */
    open func addSection(_ section: [NDDataWrapper]) {
        dataSetQueue.sync { () -> Void in
            self.rows.append(section)
            self.tagAndStoreInDictionary()
        }
    }
    
    /**
     Fetch a section using the section number
     - Parameter section: Section number
     - Returns: Array of NDDataWrapper
    */
    open func getSection(_ section: Int) -> [NDDataWrapper] {
        return rows[section]
    }
    
    open func copy(with zone: NSZone?) -> Any {
        let copy = NDFormDataSet()
        copy.rows = self.rows
        copy.objectCache = self.objectCache
        return copy
    }
    
    /**
     Get an object by conveniently passing the indexpath
     
     - Parameter indexPath: Indexpath of object to fetch
     - Returns: NDDataWrapper
    */
    open func objectAtIndexPath(_ indexPath: IndexPath) -> NDDataWrapper {
        return rows[indexPath.section][indexPath.row]
    }
    
    /**
     Get the number of rows in a section
     
     - Parameter section: The section number
     - Returns: Int
    */
    open func numberOfObjectsInSection(_ section: Int) -> Int {
        return rows[section].count
    }
    
    /**
     Returns the number of sections in the dataset
     - Returns: Int
    */
    open func numberOfSections() -> Int {
        return rows.count
    }
    
    /**
     A method to remove an object from the data set
     
     - Parameter indexPath: The indexpath of the object to b removed
     */
    open func removeObjectAtIndexPath(_ indexPath: IndexPath){}
    
    /**
     Call this method to move an object from one
     
     - Parameter fromIndexPath: The current indexPath of the object
     - Parameter toNewIndexPath: The final indexPath of the object
     */
    open func moveObjectFromIndexPath(_ fromIndexPath: IndexPath, toNewIndexPath: IndexPath){}
    
    fileprivate func initQueue() {
        dataSetQueue = DispatchQueue(label: "com.ndform.dataset", attributes: [])
    }
    
    //store object references in dict
    fileprivate func tagAndStoreInDictionary() {
        for sectionObjects in rows {
            for objWrapper in sectionObjects {
                objectCache.setObject(objWrapper, forKey: objWrapper.tag as AnyObject)
            }
        }
    }
}
