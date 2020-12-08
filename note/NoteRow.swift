//
//  NoteRow.swift
//  note
//
//  Created by Sriram P H on 28/11/20.
//

import SwiftUI

struct NoteRow: View {
    
    var noteTitle: String = ""
    var noteTimeStamp: String = ""
//    var ImageData: Data?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(noteTitle)
                    .font(.headline)
                Text(noteTimeStamp)
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }.padding()
            
//            Spacer()
//            Image(systemName: "photo.fill")
//                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .padding()
            
            
        }

        
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow(noteTitle: "Note", noteTimeStamp:"Today")
    }
}
