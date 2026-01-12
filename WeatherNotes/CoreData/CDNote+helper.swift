//
//  CDNote+helper.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 12.01.2026.
//

import Foundation
import CoreData

extension CDNote{
    public var id: UUID {
        get { id_ ?? UUID() }
        set { id_ = newValue }
    }
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    public var dateAndTime: Date {
        get { dateAndTime_ ?? Date() }
        set { dateAndTime_ = newValue }
    }
    public var temperature: Double {
        get { temperature_ }
        set { temperature_ = newValue }
    }
    
    static func delete(note : CDNote){
        guard let context = note.managedObjectContext else { return }
        context.delete(note)
        PersistenceController.shared.save()
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDNote> {
        let request = CDNote.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDNote.id_, ascending: true)]
        return request
    }
}
