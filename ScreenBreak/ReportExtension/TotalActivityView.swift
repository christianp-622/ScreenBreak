//
//  TotalActivityView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import SwiftUI


struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    private let adaptiveColumns = [GridItem(.adaptive(minimum:100))]
    private let numberColumns = [GridItem(.flexible()), GridItem(.flexible())]
    private let fixedColumns =  [GridItem(.fixed(200)), GridItem(.fixed(200))]
    
    var body: some View {
        VStack {
            /*
            Spacer(minLength: 50)
            Text("Total Screen Time")
            Spacer(minLength: 10)
            Text(activityReport.totalDuration.stringFromTimeInterval())
            Spacer(minLength: 10)
            //Text("First Pickup: \(activityReport.firstPickup?.description ?? "NIL")")
            Text("TotalPickupsWithoutApplicationActivity: \(activityReport.totalPickupsWithoutApplicationActivity)")
            Text("LongestActivity: \(activityReport.longestActivity?.description ?? "NIL")")
            Text("Categories: \(activityReport.categories.description)")
            Text("Name, numPickups, numNotifs, duration")
            */
            NavigationView{
                ScrollView{
                    LazyVGrid(columns:adaptiveColumns, spacing:10){
                        ForEach(activityReport.apps){ app in
                            CardView(app:app)
                        }
                    }
                }
                .padding()
                .navigationTitle("App Information")
            }
           
        }
    }
}



