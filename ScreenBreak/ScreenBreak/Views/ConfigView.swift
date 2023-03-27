//
//  ConfigView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI

struct ConfigView: View {
    @State private var isDiscouragedPresented = false
    @State private var isEncouragedPresented = false
    
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        NavigationView {
            VStack {
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
