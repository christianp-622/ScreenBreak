//
//  MoreInsightsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime
import SwiftUICharts
import DeviceActivity

struct MoreInsightsView: View {
    @State private var categoryContext: DeviceActivityReport.Context = .init(rawValue: "Total Pickups")
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
        // Allows us to set the the nave bar title to our custom font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

    }
    
    var body: some View {
        NavigationView {
            ScrollView(){
                VStack(spacing: 20){
                    
                    BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Pickups", legend: "", style: Styles.barChartStyleOrangeLight, form: ChartForm.extraLarge)
                    BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550), ("2020",8880)]), title: "Notifications", legend: "", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge)
                    Text("hi")
                    
                }.padding(5)
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
