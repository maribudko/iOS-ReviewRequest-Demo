//
//  SessionEntity+CoreDataProperties.swift
//  iOS-Test
//
//  Created by Mari Budko on 29.09.2025.
//
//

public import Foundation
public import CoreData

public typealias SessionEntityCoreDataPropertiesSet = NSSet

extension SessionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionEntity> {
        return NSFetchRequest<SessionEntity>(entityName: "SessionEntity")
    }

    @NSManaged public var sessionId: UUID?
    @NSManaged public var sessionStart: Date?
    @NSManaged public var sessionEnd: Date?
}

extension SessionEntity : Identifiable {

}
