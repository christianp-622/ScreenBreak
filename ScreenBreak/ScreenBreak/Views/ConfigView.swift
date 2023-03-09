//
//  ConfigView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI

struct ConfigView: View {
    var body: some View {
        NavigationView {
            Text("Configure Settings")
                .navigationTitle("Configure")
        }
        .navigationViewStyle(.stack)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
