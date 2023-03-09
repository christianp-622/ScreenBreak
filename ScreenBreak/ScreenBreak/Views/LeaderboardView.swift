//
//  LeaderboardView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI

struct LeaderboardView: View {
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
