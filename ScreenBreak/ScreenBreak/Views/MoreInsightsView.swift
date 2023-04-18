//
//  MoreInsightsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import SwiftUICharts
import RiveRuntime
import DeviceActivity



struct MoreInsightsView: View {
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "More Insights")
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
        // Allows us to set the the nav bar title to our custom font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("backgroundColor").edgesIgnoringSafeArea(.all)
                DeviceActivityReport(context, filter: filter)
            }
           
            .navigationTitle("More Insights")
            .frame(maxWidth: .infinity)
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInsightsView()
    }
}
