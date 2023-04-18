//
//  HomeView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import SwiftUICharts
import RiveRuntime
import DeviceActivity

struct HomeView: View {
    
    @State private var categoryContext: DeviceActivityReport.Context = .init(rawValue: "Home Report")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    @EnvironmentObject var model: MyModel
    let button = RiveViewModel(fileName: "button")
    @State private var isDiscouragedPresented = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

        }
    

    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    DeviceActivityReport(categoryContext, filter: filter)
                    Spacer(minLength:60)
                    
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .navigationBarTitle("Home")
                .navigationBarItems(trailing: Image("appLogo")
                    .resizable()
                    .frame(width: 70.0, height: 70.0)
                    .padding(.top)
                    .padding(.top)
                    .padding(.top))
                
            }
        }
        .navigationViewStyle(.stack)
        
    }

}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
