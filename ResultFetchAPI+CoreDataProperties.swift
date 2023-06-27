//
//  ResultFetchAPI+CoreDataProperties.swift
//  SkinPedia
//
//  Created by Rainer Regan on 27/06/23.
//
//

import Foundation
import CoreData


extension ResultFetchAPI {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultFetchAPI> {
        return NSFetchRequest<ResultFetchAPI>(entityName: "ResultFetchAPI")
    }

    @NSManaged public var resultString: String?

}

extension ResultFetchAPI : Identifiable {

}
