//
//  PickupsChartView.swift
//  ReportExtension
//
//  Created by Moe Ghanem on 4/9/23.
//

import SwiftUI
import SwiftUICharts
import DeviceActivity

struct PickupsChartView: View {
    var moreInsightsReport: MoreInsightsReport
    
    var body: some View {
        VStack{
            BarChartView(data: moreInsightsReport.pickupsChartData, title: "Pickups", legend: "By Category", style: Styles.barChartStyleOrangeLight, form: ChartForm.extraLarge)
            BarChartView(data: moreInsightsReport.notifsChartData, title: "Notifications", legend: "By Category", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge)
            Text("First Pickup: \(moreInsightsReport.firstPickup ??  "-")")
                .font ( Font(UIFont(name: "Poppins-Bold", size: 40)!)
                )
            Text("Longest Activity: \(moreInsightsReport.longestActivity ??  "-")")
                .font ( Font(UIFont(name: "Poppins-Bold", size: 40)!)
                )
            Text("Mindless App Pickups: \(moreInsightsReport.totalPickupsWithoutApplicationActivity)")
                .font ( Font(UIFont(name: "Poppins-Bold", size: 40)!)
                )
        }.padding(5)
    }
   
}

struct PickupsChartView_Previews: PreviewProvider {
    static var previews: some View {
        PickupsChartView(moreInsightsReport: <#MoreInsightsReport#>)
    }
}
