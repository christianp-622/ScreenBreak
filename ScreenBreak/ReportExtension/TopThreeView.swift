//
//  TopThreeView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 4/2/23.
//

import SwiftUI

struct TopThreeView: View {
    var topThreeReport: TopThreeReport
    private let adaptiveColumns = [GridItem(.adaptive(minimum:100))]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns:adaptiveColumns, spacing:10){
                    ForEach(topThreeReport.apps){ app in
                        CardView(app:app)
                    }
                }
            }
            .padding()
            .navigationTitle("Top Three Apps")
        }
    }
}
