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
                
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("Notes"))
                .navigationBarItems(trailing:
                                        Button(action: {
                                           
                                            print("Button performed")
                                        },
                                        label:{
                                            Label("Compose", systemImage: "camera")
                                                
                                                
                                            
                                        }
                                    
                                        )
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
