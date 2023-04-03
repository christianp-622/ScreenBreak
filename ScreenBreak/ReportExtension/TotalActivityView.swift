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



