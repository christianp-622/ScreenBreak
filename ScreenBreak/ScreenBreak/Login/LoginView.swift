//
//  LoginView.swift
//  ScreenBreak
//
//  Created by Moe Ghanem on 2/19/23.
//
import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var error: String?
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .padding(.vertical, 1.0)
                SecureField("Password", text: $password)
                    .padding(.vertical, 1.0)
                Button("Login") {
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        if let error = error {
                            self.error = error.localizedDescription
                        } else {
                            self.isLoggedIn = true
                        }
                    }
                }
                Text(error ?? "")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            .navigationTitle("Login")
            .navigationBarItems(trailing: NavigationLink(
                destination: ContentView(),
                isActive: $isLoggedIn,
                label: {
                    EmptyView()
                }
            ))
        }
    }
}

struct LoginView_Provider: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
