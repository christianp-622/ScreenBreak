//
//  HomeView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime
import DeviceActivity

struct HomeView: View {
    
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Top Three Apps")
    @State private var categoryContext: DeviceActivityReport.Context = .init(rawValue: "Total Category")
    //@State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Category")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )

    var body: some View {
        VStack {
            DeviceActivityReport(context, filter: filter)
            DeviceActivityReport(categoryContext, filter: filter)
        }
    }
    
    /*var body: some View {
        NavigationView {
            VStack{
                
                Button("Set Time Limits"){
                    print("hello world")
                }.buttonStyle(.bordered)
                
            }
            .padding()
            .navigationBarTitle("ScreenBreak")
            .navigationBarItems(trailing:
                Image("appLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .padding()
                )
        }
        .navigationViewStyle(.stack)
    }*/

}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
