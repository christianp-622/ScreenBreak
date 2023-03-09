//
//  AppsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI

struct AppsView: View {
    var body: some View {
        NavigationView {
            Text("Apps View")
                .navigationTitle("Apps View")
        }
        .navigationViewStyle(.stack)
      
    }
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}
