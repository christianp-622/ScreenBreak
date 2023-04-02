//
//  SettingsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack{
                RiveViewModel(fileName: "shapes").view()
                    .ignoresSafeArea()
                    .blur(radius:30)
                    .background(
                        Image("Spline")
                            .blur(radius:60)
                            .offset(x:200, y:100)
                    )
                Text("Settings")
            }.navigationTitle("Settings")
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
