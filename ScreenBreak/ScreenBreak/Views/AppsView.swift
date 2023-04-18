//
//  AppsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import DeviceActivity
import RiveRuntime

struct AppsView: View {
    @AppStorage("hasViewedAppsPage") var hasViewed = false
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    init() {
        // Allows us to make the navBarTitle appear in our custom font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("backgroundColor")
                    .edgesIgnoringSafeArea(.all)
                DeviceActivityReport(context, filter: filter)
                
            }
        }
        .navigationViewStyle(.stack)
    }
    
}


struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}
