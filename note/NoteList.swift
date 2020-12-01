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
    
    @State var NoteComposeSheet = false

    var body: some View {
        
        VStack{
            NavigationView {
                List{
                    ForEach(self.notes){ note in
                        NavigationLink(destination: NoteView(note: note)){
                        NoteRow(noteTitle: note.noteTitle! , noteTimeStamp: "\(note.noteTimeStamp!)")
                        }}.onDelete(perform: { indexSet in
                            let deleteItem = self.notes[indexSet.first!]
                            self.managedObjectContext.delete(deleteItem)
                            do{
                                try self.managedObjectContext.save()
                                
                            }catch{
                                print(error)
                            }
                        })
              
        
                }
                
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("Notes"))
                .navigationBarItems(trailing:
                                        
                                 NavigationLink(
                                    destination: NoteCompose(),
                                    label: {
                                        Text("Compose")
                                    })
                                    
                )
       
                            }

            
            
        }
        
//        Spacer()
//
//        VStack(alignment: .leading)
//        {
//            Label("Compose", systemImage: "square.and.pencil")
//        }
//        .foregroundColor(.accentColor)
//        .font(.system(size: 20))
//        .labelStyle(IconOnlyLabelStyle())
//        .padding()
//
//
        }

           
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
