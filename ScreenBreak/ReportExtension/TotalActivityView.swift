//
//  TotalActivityView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import SwiftUI


struct TotalActivityView: View {
    var activityReport: ActivityReport
    private var adaptiveColumns = [GridItem(.adaptive(minimum:100))]
    @State var delay = 0.1
    
    
    init(activityReport: ActivityReport) {
        self.activityReport = activityReport
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]
        }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns:adaptiveColumns, spacing:10){
                    ForEach(Array(activityReport.apps.enumerated()), id: \.offset) { index, app in
                        CardView(app: app, disablePopover:false)
                            //.animation(Animation.easeIn(duration:0.3).delay(Double(index)*0.1 + 0.2))
                           // .animation(Animation.easeIn(duration:0.3))
                    }
                }
            }
            .padding()
            .navigationBarTitle("App Insights")
        }
    }
   
}



