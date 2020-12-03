//
//  AuthView.swift
//  note
//
//  Created by Sriram P H on 03/12/20.
//

import SwiftUI

struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn(){
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            }else{
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View{
        VStack{
            
            VStack{
                Text("Sign In")
                    .padding()

                TextField("Email", text:$email)
                    .padding()

                SecureField("Password", text:$password)
                    .padding()


            }
            .padding()
      
            Button(action: signIn) {
                Text("Sign in")
            }
            .padding()
            
            if(error != ""){
                Text(error)
                    .padding()
            }
            
            NavigationLink(destination: SignUpView()){
                HStack{
               
                    Text("Create an account")
                }.padding()
            }
            
        }
        
        
    }
}

struct SignUpView: View{
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore

    func signUp(){
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error  = error.localizedDescription
            }else{
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View{
        VStack{
            Text("Sign Up")
            Text("Create new account")
            
        }
        
        VStack{
            TextField("Email", text:$email)
            SecureField("Password", text:$password)
            
            Button(action:signUp){
                Text("Create Account")
            }
     
        }
        
        if (error != ""){
            Text(error)
        }
    
    }
}

struct AuthView: View {
    
    var body: some View {
        NavigationView{
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
