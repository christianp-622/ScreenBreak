//
//  TabBar.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            AppsView()
                .tabItem{
                    Label("Apps", systemImage: "app.badge")
                }
            ConfigView()
                .tabItem{
                    Label("Configure", systemImage: "plus")
                }
            LeaderboardView()
                .tabItem{
                    Label("Configure", systemImage: "person.3")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gearshape")
                }
                
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
