//
//  PickupsChartView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 4/14/23.
//

import SwiftUI
import SwiftUICharts
import DeviceActivity

struct PickupsChartView: View {
    var moreInsightsReport: MoreInsightsReport
    
    var body: some View {
        ZStack{
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack{
                    Text("Total Pickups Per Category")
                        .customFont(.title3)
                        
                    BarChartView(data: ChartData(values: moreInsightsReport.pickupsChartData), title: "Pickups", legend: "By Category", style: Styles.barChartStyleOrangeLight, form: ChartForm.extraLarge)
                    Text("Total Notifications Per Category")
                        .customFont(.title3)
                        
                    BarChartView(data: ChartData(values: moreInsightsReport.notifsChartData), title: "Notifications", legend: "By Category", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge)
                    Text("First Pickup: \n\(moreInsightsReport.firstPickup)")
                        .customFont(.title3)
                       
                    Text("Longest Activity: \n\(moreInsightsReport.longestActivity ??  "-")")
                        .customFont(.title3)
                        
                    Text("Mindless Device Pickups: \n \(moreInsightsReport.totalPickupsWithoutApplicationActivity)")
                        .customFont(.title3)
                        
                    Spacer().frame(height:80)
                }
                .padding(5)
                .multilineTextAlignment(.center)
            }
        }
       
    }
   
}


