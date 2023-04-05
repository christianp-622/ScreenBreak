//
//  LeaderboardView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI

struct LeaderboardView: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

            //Use this if NavigationBarTitle is with displayMode = .inline
            //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
        }
    var body: some View {
        NavigationView {
            Text("Leaderboard")
                .navigationTitle("Leaderboard")
        }
        .navigationViewStyle(.stack)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
