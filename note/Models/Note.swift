//
//  Note.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import Foundation
import CoreData


//struct Note: Hashable, Codable, Identifiable{
//    var id: Int
//    var name: String
//    var data: String
//    
//}
public class Note:NSManagedObject, Identifiable{
    @NSManaged public var imageData: Data?
    @NSManaged public var noteID: UUID?
    @NSManaged public var noteText: String?
    @NSManaged public var noteTimeStamp: Date?
    @NSManaged public var noteTitle: String?
}

extension Note {
    static func getAllNotes() -> NSFetchRequest<Note>{
        let request:NSFetchRequest<Note> = Note.fetchRequest() as!
        NSFetchRequest<Note>
        
        let sortDescriptor  = NSSortDescriptor(key: "noteTimeStamp", ascending: true)
        
        request.sortDescriptors =  [sortDescriptor]
        
        return request
            
        }
    }

