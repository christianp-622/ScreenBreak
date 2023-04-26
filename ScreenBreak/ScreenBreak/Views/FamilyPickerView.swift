//
//  FamilyPickerView.swift
//  ScreenBreak
//
//  Created by Mya Mahaley on 4/11/23.
//

import SwiftUI
import FamilyControls

struct FamilyPickerView: View {
    @ObservedObject var model: MyModel
    @Binding var isDiscouragedPresented: Bool

    @State private var noAppsAlert = false
    @State private var maxAppsAlert = false
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Rectangle()
                .frame(width: 30, height: 3, alignment: .center)
                .cornerRadius(5)
                .foregroundColor(.black.opacity(0.5))
            Spacer()
            Text("App Selection")
                .customFont(.title)
                .fontWeight(.bold)
                .font(.body)
            Spacer()
            Text("Select apps to lock during Restriction Mode.")
                .customFont(.headline)
                .multilineTextAlignment(.center)
            Spacer()
            ZStack(alignment: .center) {
                Rectangle()
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                FamilyActivityPicker(selection: $model.selectionToDiscourage)
                    .padding(.all, 10)
                    
            }
            
            
            Spacer()
            Button(action : {
                if(MyModel.shared.selectionToDiscourage.applicationTokens.count == 0 && MyModel.shared.selectionToDiscourage.categoryTokens.count == 0) {
                    noAppsAlert = true
                } else {
                    isDiscouragedPresented = false
                }
            }) {
                Text("Save").customFont(.title).foregroundColor(.blue)
            }
        }
        .font(.body)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(EdgeInsets(top: 8, leading: 15, bottom: 20, trailing: 15))
        .foregroundColor(.white)
        
        .interactiveDismissDisabled()
        .alert(isPresented: $noAppsAlert) {
            Alert(
                title: Text("No Apps Selected"),
                message: Text("Please select at least 1 app.")
            )
        }
    }
}
