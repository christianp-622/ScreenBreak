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
    
    @State private var topThreecontext: DeviceActivityReport.Context = .init(rawValue: "Top Three Apps")
    @State private var categoryContext: DeviceActivityReport.Context = .init(rawValue: "Total Category")
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
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

        //Use this if NavigationBarTitle is with displayMode = .inline
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
        }

    var body: some View {
        NavigationView {
            VStack {
                DeviceActivityReport(categoryContext, filter: filter)
                DeviceActivityReport(topThreecontext, filter: filter)
                button.view()
                    .frame(width: 236, height:64)
                    .overlay(
                        Label("Select Apps to Lock", systemImage:"arrow.forward")
                            .offset(x:4, y: 4)
                            .font(.headline)
                    )
                    .background(
                        Color.black
                            .cornerRadius(30)
                            .blur(radius:10)
                            .opacity(0.3)
                            .offset(y:10)
                    )
                    .onTapGesture{
                        try? button.play(animationName:"active")
                        
                        isDiscouragedPresented = true
                    }
                    .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                
                Spacer(minLength: 80)
                    .navigationBarTitle("Home")
                
            }.onChange(of: model.selectionToDiscourage) { newSelection in
            MyModel.shared.setShieldRestrictions()}
        }
    }
    
    var topApps: some View{
        Text("")
    }

}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
