//
//  NoteDetail.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI
//import UIKit


struct NoteCompose: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes: FetchedResults<Note>
    
//    var note: Note

    @State public var noteText: String = "Untitled"
    
    
    
@State var isShowingImagePicker = false
    
    @State var imageInContainer = UIImage()
    
//    var imageData = self.$ImageInContainer.jpegData(compressionQuality: 1)
    
    
    var body: some View {
        
            
            VStack(alignment: .leading){
         
                ScrollView{
                    TextEditor(text: self.$noteText)
                        .padding()
                }
               
     

            }.onTapGesture {
                self.hideKeyboard()}
            
            HStack{
                Image(uiImage: imageInContainer)
                    .resizable()
                    .scaledToFill()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .padding()

            }
  
            HStack
            {
                Button(action: {
                    self.isShowingImagePicker.toggle()
                    print("Button performed")
                },
                label:{
                    Label("Image", systemImage: "camera")
                        
                    
                })
                .sheet(isPresented: $isShowingImagePicker, content: {
                    ImagePickerView(isPresented: self.$isShowingImagePicker,
                                    selectedImage: self.$imageInContainer)
                    
                })
            

                            
                Spacer()
                Label("Delete", systemImage: "trash")
            }
            .foregroundColor(.accentColor)
            .font(.system(size: 20))
            .labelStyle(IconOnlyLabelStyle())
            .padding()
    
        .navigationTitle(self.noteText)
        .navigationBarItems(trailing:
      Button(action: {
        let note = Note(context: self.managedObjectContext)
            note.noteTitle = self.noteText
        note.noteText = self.noteText
        note.noteTimeStamp = Date()
        note.imageData = self.imageInContainer.jpegData(compressionQuality: 1)

        do {
            try self.managedObjectContext.save()
    
        }catch{
            print(error)
        }
                        self.noteText = ""
        
    }) {
        Image(systemName: "plus.circle.fill")
            .foregroundColor(.white)
            .font(.system(size: 20))

            
    }
        )
    }

}


struct NoteCompose_Previews: PreviewProvider {
    static var previews: some View {
        NoteCompose()
        
    }
}
