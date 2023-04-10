//
//  CategoryChartView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import SwiftUICharts
import DeviceActivity
import Charts

struct CategoryChartView: View {
    var categoryReport: CategoryReport
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                //Text("Total Screen Time: \(categoryReport.totalDuration.formatedDuration())").customFont(.headline)
                VStack{
                    //Text("Daily Insights").customFont(.subheadline)
                    TabView{
                        BarChartView(data: ChartData(values: categoryReport.chartData), title: "Minutes ",legend: "Categories", style: Styles.barChartStyleNeonBlueLight,form:ChartForm.medium,dropShadow:true)
                        BarChartView(data: ChartData(values: categoryReport.appChartData), title: "Apps", legend: "App Time",form:ChartForm.medium,dropShadow:true)
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(
                        .page(backgroundDisplayMode:
                            .interactive))
                }
            }
        }
        /*
        ScrollView {
            VStack {
                Text("Screen Time Categories").font(.title)
                Text("Total Screen Time: \(categoryReport.totalDuration.stringFromTimeInterval())").customFont(.subheadline)
                Chart(categoryReport.categories) { categoryActivity in
                    // 1. Swap the X and Y values
                    BarMark(
                        x: .value("Category", categoryActivity.category),
                        y: .value("Time Spent", categoryActivity.duration)
                    ).cornerRadius(20)
                        .annotation(position: .trailing) {
                            Text(categoryActivity.duration.stringFromTimeInterval())
                                .foregroundColor(Color.gray)
                    }.foregroundStyle(.linearGradient(
                        colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing)
                        )

                }.frame(height: 400)
                // 1. Functions for modifying axis labels
                .padding()
            }.padding()
        }
        */
    }
}


