//
//  MoreInsightsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime

struct MoreInsightsView: View {
    
    init() {
        // Allows us to set the the nave bar title to our custom font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Text("More Insights")
                    
                
            }.navigationTitle("More Insights")
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInsightsView()
    }
}
