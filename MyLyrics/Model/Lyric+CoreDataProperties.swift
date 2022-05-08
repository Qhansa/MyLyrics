//
//  Lyric+CoreDataProperties.swift
//  MyLyrics
//
//  Created by Qhansa D. Bayu on 08/05/22.
//
//

import Foundation
import CoreData


extension Lyric {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lyric> {
        return NSFetchRequest<Lyric>(entityName: "Lyric")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var ideas: String?
    @NSManaged public var deletedDate: Date?

}

extension Lyric : Identifiable {

}
