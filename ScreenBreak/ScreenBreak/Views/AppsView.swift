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
            ChartView()
        }
        .navigationViewStyle(.stack)
    }
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}
