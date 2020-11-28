//
//  NoteDetail.swift
//  note
//
//  Created by Sriram P H on 27/11/20.
//

import SwiftUI
//import UIKit


struct NoteView: View {
    var note: Note
    @State public var fullText: String = noteData[0].name
@State var isShowingImagePicker = false
    
    @State var imageInContainer = UIImage()
    
    
    var body: some View {
        Section {
            VStack{
                ScrollView{
                    TextEditor(text: $fullText)
                        .padding()
                }
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
                .foregroundColor(.black)
                .font(.system(size: 20))
                .labelStyle(IconOnlyLabelStyle())
                .padding()

            }
    
            
        }
   
        .navigationBarTitle(Text(note.name), displayMode: .inline)

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

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NoteView(note: noteData[0])
            
        }
    }
}
