//
//  NoteRow.swift
//  note
//
//  Created by Sriram P H on 28/11/20.
//

import SwiftUI

struct NoteRow: View {
    
    var noteTitle: String = ""
    var noteTimeStamp: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(noteTitle)
                .font(.headline)
            Text(noteTimeStamp)
                .font(.caption)
                .foregroundColor(.gray)
        }
        
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow(noteTitle: "Note", noteTimeStamp:"Today")
    }
}
