//
//  HomeReportView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import SwiftUICharts
import DeviceActivity
import Charts


struct HomeReportView: View {
    
    var homeReport: ChartAndTopThreeReport
    private let fixedColumns =  [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
       
            VStack{
                card
                    
                Spacer(minLength:20)
                Text("Screen Time Today").customFont(.title2)
                Text("\(homeReport.totalDuration.formatedDuration())")
                    .customFont(.headline)
                Rectangle()
                    .fill(Color("border"))
                    .frame(width:200, height: 3)
                    .edgesIgnoringSafeArea(.horizontal)
                    .background(.clear)
                
                TabView{
                    BarChartView(data: ChartData(values: homeReport.categoryChartData), title: "Category Minutes",legend: "Categories", style: Styles.barChartMidnightGreenLight,form:ChartForm.extraLarge,dropShadow:true, cornerImage:Image(systemName:"clock"))
                    BarChartView(data: ChartData(values: homeReport.appChartData), title: "App Minutes", legend: "App Time",style: Styles.barChartStyleNeonBlueLight,form:ChartForm.extraLarge ,dropShadow:true, cornerImage:Image(systemName:"apps.iphone"))
                }
                .frame(height:320)
                .layoutPriority(1)
                .tabViewStyle(.page)
                .indexViewStyle(
                    .page(backgroundDisplayMode:
                            .always))
            }
            
        }
    }
    var card: some View{
        VStack(alignment:.center){
            Text("Top Apps")
                .customFont(.title2)
            
            Rectangle()
                .fill(Color("border"))
                .frame(width:150, height: 3)
                .edgesIgnoringSafeArea(.horizontal)
            
            LazyVGrid(columns:fixedColumns, spacing:2){
                ForEach(homeReport.topApps){ app in
                    CardView(app:app, disablePopover: true)
                }
            }
        }
        .padding()

    }
}


