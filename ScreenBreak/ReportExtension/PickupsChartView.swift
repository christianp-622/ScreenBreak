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
                    
                    TabView{
                        VStack{
                            Text("Category Pickups")
                                .customFont(.headline)
                                .underline()
                            BarChartView(data: ChartData(values: moreInsightsReport.pickupsChartData), title: "Pickups",legend: "Pickups", style: Styles.barChartMidnightGreenLight,form:ChartForm.extraLarge,dropShadow:true, cornerImage:Image(systemName:"hand.tap"))
                                
                        }
                        VStack{
                            Text("Category Notifications")
                                .customFont(.headline)
                                .underline()
                            BarChartView(data: ChartData(values: moreInsightsReport.notifsChartData), title: "Notifications", legend: "Notifications",style: Styles.barChartStyleNeonBlueLight,form:ChartForm.extraLarge ,dropShadow:true, cornerImage:Image(systemName:"message.badge"))
                                
                        }
                        
                    }
                    .frame(height:320)
                    .padding(.bottom)
                    .tabViewStyle(.page)
                    .indexViewStyle(
                        .page(backgroundDisplayMode:
                                .always))
              
                    
                    TabView{
                        VStack{
                            Text("Application Pickups")
                                .customFont(.headline)
                                .underline()
                            BarChartView(data: ChartData(values: moreInsightsReport.pickupsAppChartData), title: "Pickups",legend: "Pickups", style: Styles.barChartMidnightGreenLight,form:ChartForm.extraLarge,dropShadow:true, cornerImage:Image(systemName:"hand.tap"))
                            }
                        VStack{
                            Text("Application Notifications")
                                .customFont(.headline)
                                .underline()
                            BarChartView(data: ChartData(values: moreInsightsReport.notifsAppChartData), title: "Notifications", legend: "Notifications",style: Styles.barChartStyleNeonBlueLight,form:ChartForm.extraLarge ,dropShadow:true, cornerImage:Image(systemName:"message.badge"))
                        }
                    }
                    .frame(height:320)
                    .padding(.bottom)
                    .tabViewStyle(.page)
                    .indexViewStyle(
                        .page(backgroundDisplayMode:
                                .always))
                    RoundedRectangle(cornerRadius: 2).frame(width:UIScreen.main.bounds.width * 0.9, height: 3)

                    Text("First Pickup: \n\(moreInsightsReport.firstPickup)")
                        .customFont(.title3)
                        
                    Text("Mindless Device Pickups: \n \(moreInsightsReport.totalPickupsWithoutApplicationActivity)")
                        .customFont(.title3)
                        
                    Spacer()
                        .frame(height:80)
                }
                .padding(5)
                .multilineTextAlignment(.center)
            }
        }
       
    }
   
}


