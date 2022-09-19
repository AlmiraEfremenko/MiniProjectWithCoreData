//
//  ModelUsers+CoreDataProperties.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 16.09.2022.
//
//

import Foundation
import CoreData

@objc(ModelUsers)
public class ModelUsers: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var gender: String?
   
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelUsers> {
        return NSFetchRequest<ModelUsers>(entityName: "ModelUsers")
    }
}
