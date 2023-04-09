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
    let button = RiveViewModel(fileName: "button")
    
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Select Apps to Discourage") {
                    isDiscouragedPresented = true
                }
                .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                
                
                List(Array(MyModel.shared.selectionToDiscourage.applicationTokens), id: \.self) { token in
                    Label(token)
                }
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
