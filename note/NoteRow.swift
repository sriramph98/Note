//
//  NoteRow.swift
//  note
//
//  Created by Sriram P H on 28/11/20.
//

import SwiftUI

struct NoteRow: View {
    
    var note: Note
    var body: some View {
        Text(note.name)
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow(note: noteData[0])
    }
}
