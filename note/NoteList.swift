//
//  ContentView.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI

struct NoteList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    
    
    var body: some View {
        
   
            NavigationView {
                List{
                    ForEach(self.notes){ note in
                        NavigationLink(destination: NoteView()){
                        NoteRow(noteTitle: note.noteTitle! , noteTimeStamp: "\(note.noteTimeStamp!)")
                        }}.onDelete(perform: { indexSet in
                            let deleteItem = self.notes[indexSet.first!]
                            self.managedObjectContext.delete(deleteItem)
                            do{try self.managedObjectContext.save()
                                
                            }catch{
                                print(error)
                            }
                        })
                    
                     
                    
//                    note in
//                    NavigationLink(destination: NoteView(note: note)) {
//                        NoteRow(note: note)
//                    }
                }
                
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("Notes"))
                .navigationBarItems(trailing:
                                        NavigationLink(destination: NoteView()){
                                            Text("Compose")
                                        }
                                        .labelStyle(TitleOnlyLabelStyle())


                )
                            }
        
        }

           
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
