//
//  TotalActivityView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import SwiftUI
import ManagedSettingsUI


struct TotalActivityView: View {
    var activityReport: ActivityReport
    private var adaptiveColumns = [GridItem(.adaptive(minimum:100))]
    
    @State var delay = 0.1
    @State private var offset = CGSize.zero
    @State private var isShowingAnimation = false
    
    init(activityReport: ActivityReport) {
        self.activityReport = activityReport
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]
        }
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            NavigationView{
                ZStack{
                    Color("backgroundColor")
                        .edgesIgnoringSafeArea(.all)
                    appsScrollView
                }
                .navigationTitle("Screen Time")
            }
            .padding()
        }
        
    }
    
    var appsScrollView: some View{
        ScrollView{
            VStack(alignment: .center, spacing: 20) {
                ForEach(0...activityReport.apps.count/3, id: \.self){index in
                    HStack(alignment: .top, spacing: 5) {
                        Spacer()
                        let offset = index * 3
                        ForEach(offset...(offset+2), id: \.self){index2 in
                            if index2 < activityReport.apps.count{
                                CardView(app:activityReport.apps[index2], disablePopover: false)
                                    .frame(minWidth: 120)

                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
               
                
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            
        }
    }
    
    var animation: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 50, height: 50)
                .offset(offset)
            
            Image(systemName: "arrow.up.right")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .offset(x: 25, y: -25)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { value in
                    offset = CGSize.zero
                }
        )
    }
}







