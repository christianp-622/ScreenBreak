//
//  SignInView.swift
//  ScreenBreak
//
//  Created by Moe Ghanem on 2/28/23.
//

import SwiftUI

struct SignInView: View {
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView(), tag: "login", selection: $selection){}
                NavigationLink(destination: RegisterView(), tag: "reg", selection: $selection){}
                Button{
                    self.selection = "login"
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .scaledToFill()
                
                Button{
                    self.selection = "reg"
                } label: {
                    Text("Register an Account")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .scaledToFill()

            }
            .padding()
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            .navigationTitle("Sign In")
        }
    }
}

struct SignInView_Provider: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
