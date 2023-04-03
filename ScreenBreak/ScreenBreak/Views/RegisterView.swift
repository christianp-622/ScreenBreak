//
//  RegisterView.swift
//  ScreenBreak
//
//  Created by Moe Ghanem on 2/19/23.
//
import SwiftUI
import Firebase
import RiveRuntime

struct RegisterView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var error: String?
    @State private var isLoggedIn = false
    @State private var toRegister = false
    
    var body: some View {
        ZStack {
            RiveViewModel(fileName: "shapes").view()
                .ignoresSafeArea()
                .blur(radius:30)
                .background(
                    Image("Spline")
                        .blur(radius:60)
                        .offset(x:200, y:100)
                )
            VStack {
                    TextField("Email", text: $email)
                        .padding(.vertical, 1.0)
                    
                    SecureField("Password", text: $password)
                        .padding(.vertical, 1.0)
                        
                        
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding(.vertical, 1.0)
                    Button("Create an account") {
                        
                        if (password != confirmPassword){
                            self.error = "Passwords do not match"
                        } else {
                            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                                if let error = error {
                                    self.error = error.localizedDescription
                                } else {
                                    self.isLoggedIn = true
                                }
                            }
                        }
                    }
                    Text(error ?? "")
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
                .navigationTitle("Register")
                .navigationBarItems(trailing: NavigationLink(
                    destination: ContentView().navigationBarBackButtonHidden(true),
                    isActive: $isLoggedIn,
                    label: {
                        EmptyView()
                    }
            ))
        }
    }
}

struct RegisterView_Provider: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
