//
//  WidgetReportView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 4/11/23.
//

import SwiftUI

struct WidgetReportView: View {
    var widgetReport: TotalActivityWidgetReport
    
    var body: some View {
        ZStack{
            ContainerRelativeShape().fill(Color("backgroundColor").gradient.opacity(0.9))
            Text("Total Screen Time: ")
            Text("\(widgetReport.totalDuration)")
            
        }
        .frame(width:100, height:100)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color("borderColor"), lineWidth: 5)
        )
    }
}


