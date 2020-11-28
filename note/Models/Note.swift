//
//  Note.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI
import Foundation


struct Note: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    var data: String
    
}
