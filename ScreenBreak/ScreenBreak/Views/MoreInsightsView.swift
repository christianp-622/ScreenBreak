//
//  MoreInsightsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import SwiftUICharts
import RiveRuntime



struct MoreInsightsView: View {

    init() {
        // Allows us to set the the nave bar title to our custom font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

    }
    
    var body: some View {
        NavigationView {
            VStack{
                Text("More Insights")
                
                TabView{
                    BarChartView(data: ChartData(points:[1.23,2.43,3.37]) ,title: "A", style: Styles.barChartStyleNeonBlueDark, valueSpecifier: "%.2f")
                    BarChartView(data: ChartData(points:[8,23,54,32,12,37,7,23,43]), title: "Title", style: Styles.barChartMidnightGreenLight)
                    BarChartView(data: ChartData(points:[1.23,2.43,3.37]) ,title: "C", valueSpecifier: "%.2f")
                    LineChartView(data: [1.0, 2.0, 3.0, 2.0, 5.0], title: "Line Chart")
                    LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Full screen")
                
                }
                
                .tabViewStyle(.page)
                .indexViewStyle(
                    .page(backgroundDisplayMode:
                        .interactive))
            }
            .padding()
            .navigationTitle("More Insights")
        }
        .navigationViewStyle(.stack)
    }
}
 

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInsightsView()
    }
}
