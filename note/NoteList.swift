//
//  ContentView.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI
import Firebase
import UIKit


struct NoteList: View {


    
//    @State private var selectedView: Int? = 0
    
//    @EnvironmentObject var session: SessionStore
    //    func getUser(){
    //
    //        session.listen()
    //    }
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    

    var body: some View {
        
            
            VStack{
                NavigationView{
                        List{
                            ForEach(self.notes){ note in
                                NavigationLink(destination: NoteView(note: note)){
                                    NoteRow(noteTitle: note.noteTitle! , noteTimeStamp: "\(note.noteTimeStamp!)").lineLimit(1)
                                        
                                }
                                .contextMenu(ContextMenu(){
                                    
                                    Button(action: {
                                        self.managedObjectContext.delete(note)
                                    }) {
                                        HStack{
                                            Text("Delete")
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                
                                )
                            }
                            
                                
                                .onDelete(perform: { indexSet in
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
                        .navigationBarItems(
                            
//                            leading:     Button(action: session.signOut){
//                            Image(systemName:"person.crop.circle")
//                                .font(.system(size: 20))
//
//                        },
                
                            trailing:
                            
                            NavigationLink(
                                destination: NoteView(note:nil),

                                label: {
                                    Image(systemName:"square.and.pencil")
                                        .font(.system(size: 20))

                                    
                                })  )
                    
                        
                    }
                    
                    //                        .onAppear{
                    //                            let device = UIDevice.current
                    //                            if device.model == "iPad" && device.orientation.isLandscape{
                    //                                self.selectedView = 1
                    //                            } else {
                    //                                self.selectedView = 0
                    //                            }
                    //                        }
                    //                        .navigationViewStyle(StackNavigationViewStyle())
                    
//                if (session.session != nil){
//
//                }else{
//                    AuthView()
//                }
            }
//            .onAppear(perform: getUser)
            
        
        
    }
    
}



struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}

