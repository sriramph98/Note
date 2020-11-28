//
//  NoteDetail.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI
//import UIKit


struct NoteView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes: FetchedResults<Note>
    
//    var note: Note

    @State private var noteText:String  = "Edit"
    
    
    
@State var isShowingImagePicker = false
    
    @State var imageInContainer = UIImage()
    let imageData = UIImage().pngData()
    
    
    var body: some View {
        Section {
            
            VStack{
//                ScrollView{
                    TextEditor(text: self.$noteText)
                        .padding()
//                }
                HStack{
                    Image(uiImage: imageInContainer)
                        .resizable()
                        .scaledToFit()

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

            }.onTapGesture {
                self.hideKeyboard()}
    
            
        }
        .navigationTitle(self.noteText)
        .navigationBarItems(trailing:
                                Button(action: {
                                    let note = Note(context: self.managedObjectContext)
                                    note.noteTitle = self.noteText
                                    note.noteTimeStamp = Date()
                                    note.image = self.imageData
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                
                                    }catch{
                                        print(error)
                                    }
//                                    self.newNote = ""
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                }
        )
    }

}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context:
        UIViewControllerRepresentableContext<ImagePickerView>) ->
    UIViewController {
        let controller = UIImagePickerController()
       controller.delegate = context.coordinator
        return controller
    }
    func makeCoordinator() -> ImagePickerView.Cooridnator {
        return Cooridnator(parent: self)
    }
    
    class Cooridnator: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        let parent: ImagePickerView
        init(parent: ImagePickerView){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage{
                self.parent.selectedImage = selectedImageFromPicker
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController:
                                    ImagePickerView.UIViewControllerType , context:
    UIViewControllerRepresentableContext<ImagePickerView>) {
    }
    
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
            NoteView()
        
    }
}
