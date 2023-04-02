//
//  CategoryChartView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import DeviceActivity
import Charts

struct CategoryChartView: View {
    var categoryReport: CategoryReport
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Screen Time Categories").font(.title)
                Text("Total Screen Time: \(categoryReport.totalDuration.stringFromTimeInterval())").font(.subheadline)
                Chart(categoryReport.categories) { categoryActivity in
                    // 1. Swap the X and Y values
                    BarMark(
                        x: .value("Time Spent", categoryActivity.duration),
                        y: .value("Category", categoryActivity.category)
                    ).cornerRadius(20)
                        .annotation(position: .trailing) {
                            Text(categoryActivity.duration.stringFromTimeInterval())
                                .foregroundColor(Color.gray)
                    }.foregroundStyle(.linearGradient(
                        colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing)
                        )

                }.frame(height: 800)
                // 1. Functions for modifying axis labels
                .chartYAxisLabel("Category")
                .padding()
            }.padding()
        }
    }
}


