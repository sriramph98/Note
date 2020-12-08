//
//  NoteView.swift
//  note
//
//  Created by Sriram P H on 29/11/20.
//

import SwiftUI
import UIKit
import QuickLook

struct NoteView: View {
    
    func save(){
        if (note == nil)  {
            if self.noteText == "" && self.imageFromPicker.cgImage == nil {
                return
            }
            let note = Note(context: self.managedObjectContext)
            note.noteTitle = self.noteText
            note.noteText = self.noteText
            note.noteTimeStamp = Date()
            note.imageData = self.imageFromPicker.jpegData(compressionQuality: 1)
            
            
            
            do {
                try self.managedObjectContext.save()
            }catch{
                print(error)
            }
        }
        else{
            note?.noteTitle = self.noteText
            note?.noteText = self.noteText
            note?.noteTimeStamp = Date()
            if let d = self.imageFromPicker.jpegData(compressionQuality: 1) {
                note?.imageData = d
                
            }
        }
    }
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes: FetchedResults<Note>
    
    var note: Note?
    @State var noteText: String
    var uiImage: UIImage
    @State private var bgColor = Color.white
    
    init(note: Note?){
        self.note = note
        
        // _noteText will initialize noteText from the `Note` sent to us
        _noteText = State(initialValue: self.note?.noteTitle ?? "")
        let imageData = self.note?.imageData ?? Data()
        
        if let image = UIImage(data: imageData) {
            uiImage = image
        } else {
            uiImage = UIImage()
        }
    }
    
    //
    
    
    @State var isShowingImagePicker = false
    @State var isShowingColorPicker = false
    @State var imageFromPicker = UIImage()
    
    var body: some View {
        
        
        VStack {
            VStack(alignment: .leading){
                
                TextEditor(text: self.$noteText)
                    .padding()
                
                
                ScrollView(.horizontal,showsIndicators:false){
                    
                    
                    
                    HStack{
                        
                        Image(uiImage: self.uiImage)
                            
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .contentShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .cornerRadius(5)
                            .padding()
                            .contextMenu(ContextMenu(){
                                Button(action: {
                                    self.note?.imageData = nil
                                    do{
                                        try self.managedObjectContext.save()
                                        
                                    }catch{
                                        print(error)
                                    }
                                }) {
                                    HStack{
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                            })
                        
                        Image(uiImage: self.imageFromPicker)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(5)
                            .padding()
                        
                        
                    }
                    
                    
                    
                }
                
                
                HStack
                {
                    Button(action: {
                        self.isShowingImagePicker.toggle()
                    },
                    label:{
                        Label("Image", systemImage: "camera")
                        
                        
                    })
                    .sheet(isPresented: $isShowingImagePicker, content: {
                        ImagePickerView(isPresented: self.$isShowingImagePicker,
                                        selectedImage: self.$imageFromPicker)
                            .onDisappear(perform: {
                                if let d = self.imageFromPicker.jpegData(compressionQuality: 1) {
                                    note?.imageData = d
                                }
                            })
                    })
                    
                    Spacer()
                    Label("Format", systemImage: "bold.italic.underline")
                    Spacer()
                    
                    ColorPicker("Select a color", selection: self.$bgColor)
                        .labelsHidden()
                    
                    
                    Spacer()
                    Button(action: {
                        if (note != nil){
                            self.managedObjectContext.delete(self.note!)
                            
                        }
                        
                        do{
                            try self.managedObjectContext.save()
                            
                        }catch{
                            print(error)
                        }
                    }
                    ,
                    label:{
                        Label("Delete", systemImage: "trash")
                        //                            .foregroundColor(.red)
                        
                        
                    })
                    
                }
                
                .foregroundColor(.accentColor)
                .font(.system(size: 20))
                .labelStyle(IconOnlyLabelStyle())
                .padding()
                
            }.onTapGesture {
                self.hideKeyboard()}
            
            
        }
        .onDisappear(perform: {
            save()
        })
        .navigationTitle(self.noteText)
        .navigationBarItems(trailing:
                                Button(action: {
                                    
                                },    label:{
                                    Image(systemName: "ellipsis.circle")
                                        .foregroundColor(.accentColor)
                                        .font(.system(size: 20))

                                }
                                )
                                
                            
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




//
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: nil)
        
    }
}
