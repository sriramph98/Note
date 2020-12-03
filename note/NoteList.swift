//
//  ContentView.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI

struct NoteList: View {
    @EnvironmentObject var session: SessionStore

    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    
    @State var NoteComposeSheet = false

    
    func getUser(){
        
        session.listen()
    }
    var body: some View {
        
        VStack{
            
            VStack{
                    if (session.session != nil){
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
                            
                            .navigationBarItems(leading:     Button(action: session.signOut){
                                Image(systemName:"person.crop.circle")
                                    .font(.system(size: 20))

                            }, trailing:
                                
                                NavigationLink(
                                    destination: NoteCompose(),
                                    label: {
                                        Image(systemName:"square.and.pencil")
                                            .font(.system(size: 20))
                                        
                                    })  )
                                        }
                        
                   
                    }else{
                            AuthView()
                        }
                }.onAppear(perform: getUser)

        }
  
        }
           
        }

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
