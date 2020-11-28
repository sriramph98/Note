//
//  ContentView.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI

struct NoteList: View {
    var body: some View {
        NavigationView {
            List(noteData) { note in
                NavigationLink(destination: NoteView(note: note)) {
                    NoteRow(note: note)
                }
            }
            .navigationBarTitle(Text("Notes"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
