//
//  LeaderboardView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import SwiftUICharts

struct LeaderboardView: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

            //Use this if NavigationBarTitle is with displayMode = .inline
            //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
        }
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello")
                    .customFont(.largeTitle)
                
                HStack {
                    
                    TabView{
                        BarChartView(data: ChartData(points:[8,23,54,32,12,37,7,23,43]), title: "Categories", style: Styles.barChartStyleNeonBlueLight, form:ChartForm.large)
                        PieChartView(data: [8.0,23.0,54.0,32.0], title: "Categores", legend: "Legendary", style:Styles.barChartMidnightGreenLight, form:ChartForm.large)
                        MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Categories", form:ChartForm.large)
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(
                        .page(backgroundDisplayMode:
                            .interactive))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.96, height:300)
            .cornerRadius(10)
            .mask(RoundedRectangle(cornerRadius:40, style:.continuous))
            
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 1)
            )
            
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
