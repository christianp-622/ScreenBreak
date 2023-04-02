//
//  ConfigView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime

struct ConfigView: View {
    @State private var isDiscouragedPresented = false
    @State private var isEncouragedPresented = false
    let button = RiveViewModel(fileName: "button")
    
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        NavigationView {
            VStack {
                button.view()
                    .frame(width: 236, height:64)
                    .overlay(
                        Label("Select Apps to Lock", systemImage:"arrow.forward")
                            .offset(x:4, y: 4)
                            .font(.headline)
                    )
                    .background(
                        Color.black
                            .cornerRadius(30)
                            .blur(radius:10)
                            .opacity(0.3)
                            .offset(y:10)
                    )
                    .onTapGesture{
                        try? button.play(animationName:"active")
                        
                        isDiscouragedPresented = true
                    }
                    
                
                Button("Select Apps to Discourage") {
                    isDiscouragedPresented = true
                }
                .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                
                Button("Select Apps to Encourage") {
                    isEncouragedPresented = true
                }
                .familyActivityPicker(isPresented: $isEncouragedPresented, selection: $model.selectionToEncourage)
            }
            .onChange(of: model.selectionToDiscourage) { newSelection in
                MyModel.shared.setShieldRestrictions()}
        }
        .navigationViewStyle(.stack)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
