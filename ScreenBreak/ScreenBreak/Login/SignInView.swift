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
                NavigationLink(destination: LoginView()){ Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                
                NavigationLink(destination: RegisterView()){
                    Text("Register an Account")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                
                NavigationLink(destination: ContentView() .navigationBarBackButtonHidden(true))
                {
                    Text("SKIP (DELETE WHEN DEPLOYED)")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                
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
