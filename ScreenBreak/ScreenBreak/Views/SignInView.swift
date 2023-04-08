//
//  SignInView.swift
//  ScreenBreak
//
//  Created by Moe Ghanem on 2/28/23.
//

import SwiftUI
import FirebaseAuth
import RiveRuntime
import ManagedSettings

struct SignInView: View {
    
    // Declare a presentation mode environment variable to dismiss this view
    @Environment(\.presentationMode) var presentationMode
    
    @State var phoneNumber = ""
    @State var verificationCode = ""
    @State var verificationID: String?
    @State var showErrorAlert = false
    @State var errorMessage = ""
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @StateObject var model = MyModel.shared
    @StateObject var store = ManagedSettingsStore()
    
    var body: some View {
        VStack {
            TextField("Phone Number", text: $phoneNumber)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal)
            
            Button(action: {
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                    if let error = error {
                        showErrorAlert = true
                        errorMessage = error.localizedDescription
                        return
                    }
                    self.verificationID = verificationID
                }
            }) {
                Text("Send Verification Code")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding(.horizontal)
                    //.buttonBorderShape(capsule)
            }
            
            TextField("Verification Code", text: $verificationCode)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal)
            
            Button(action: {
                guard let verificationID = verificationID else { return }
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                        showErrorAlert = true
                        errorMessage = error.localizedDescription
                        return
                    }
                    // Sign in successful
                    ContentView().environmentObject(model).environmentObject(store)
                }
            }) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding(.horizontal)
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignInView_Provider: PreviewProvider {
    static var previews: some View {
        SignInView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(LaunchScreenManager())
    }
}
