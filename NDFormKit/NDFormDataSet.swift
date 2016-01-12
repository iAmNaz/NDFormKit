//
//  NDFormDataSet.swift
//  NDForm
//
//  Created by Jun MeAol on 05/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit

/// This class makes it convenient to organize data for UITableViews
public class NDFormDataSet: NSObject, NSCopying {
    /**
     A multidimensional array of NDDataWrappers. The structure is synonymous to UITableView's section and rows.
    */
    public var rows:[[NDDataWrapper]]!
    /**
     Adding a new row is done on a different queue
    */
    private var dataSetQueue: dispatch_queue_t!
    /**
     NSMapTable can hold keys and values with weak references, in such a way that entries are removed when either the key or value is deallocated
     */
    private var objectCache:NSMapTable!
    
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
    public func objectWithTag(tag: String) -> NDDataWrapper? {
        return objectCache.objectForKey(tag) as? NDDataWrapper
    }
    
    /**
     A section can be added using this method
     
     - Parameter section: An array of NDDataWrapper added to the dataset
     - Returns: Void
    */
    public func addSection(section: [NDDataWrapper]) {
        dispatch_sync(dataSetQueue) { () -> Void in
            self.rows.append(section)
            self.tagAndStoreInDictionary()
        }
    }
    
    /**
     Fetch a section using the section number
     - Parameter section: Section number
     - Returns: Array of NDDataWrapper
    */
    public func getSection(section: Int) -> [NDDataWrapper] {
        return rows[section]
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
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
    public func objectAtIndexPath(indexPath: NSIndexPath) -> NDDataWrapper {
        return rows[indexPath.section][indexPath.row]
    }
    
    /**
     Get the number of rows in a section
     
     - Parameter section: The section number
     - Returns: Int
    */
    public func numberOfObjectsInSection(section: Int) -> Int {
        return rows[section].count
    }
    
    /**
     Returns the number of sections in the dataset
     - Returns: Int
    */
    public func numberOfSections() -> Int {
        return rows.count
    }
    
    /**
     A method to remove an object from the data set
     
     - Parameter indexPath: The indexpath of the object to b removed
     */
    public func removeObjectAtIndexPath(indexPath: NSIndexPath){}
    
    /**
     Call this method to move an object from one
     
     - Parameter fromIndexPath: The current indexPath of the object
     - Parameter toNewIndexPath: The final indexPath of the object
     */
    public func moveObjectFromIndexPath(fromIndexPath: NSIndexPath, toNewIndexPath: NSIndexPath){}
    
    private func initQueue() {
        dataSetQueue = dispatch_queue_create("com.ndform.dataset", nil)
    }
    
    //store object references in dict
    private func tagAndStoreInDictionary() {
        for sectionObjects in rows {
            for objWrapper in sectionObjects {
                objectCache.setObject(objWrapper, forKey: objWrapper.tag)
            }
        }
    }
}
