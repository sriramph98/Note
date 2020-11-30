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
        
            
            VStack(alignment: .trailing){
         
                ScrollView{
                    TextEditor(text: self.$noteText)
                        .padding()
                }
               
     

            }.onTapGesture {
                self.hideKeyboard()}
            
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
            .foregroundColor(.green)
            .font(.system(size: 25))

            
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

struct NoteCompose_Previews: PreviewProvider {
    static var previews: some View {
        NoteCompose()
        
    }
}
