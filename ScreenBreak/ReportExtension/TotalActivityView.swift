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
    
    @State private var showHelp = false
    @State private var scale = 0.1
    
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            showHelp.toggle()
                            scale = 0.1
                        }) {
                            Image(systemName: "questionmark.circle")
                                .renderingMode(.original)
                        }
                    }
                    
                }

            }
            
            
            if showHelp{
                tutorialApps
                    .scaleEffect(scale)
                    .onAppear{
                        withAnimation(.easeInOut(duration: 0.3)) {
                            scale = 1.1
                        }
                    }
            }
        }
        
    }
    
    var appsScrollView: some View{
        ScrollView{
            Spacer(minLength:20)
            VStack(alignment: .center, spacing: 40) {
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
                Spacer(minLength:50)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            
        }
        .disabled(showHelp)
        .blur(radius: showHelp ? 20: 0)
    }
    
    var tutorialApps: some View{
        ZStack{
            Color(.lightGray).opacity(0.7)
            VStack(alignment:.center){
                Text("Tap on any icon to view the corresponding application's insights")
                    .customFont(.headline)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height:30)
                Button{
                    showHelp.toggle()
                    scale = 0.1
                }label:{
                    Text("OK")
                        .customFont(.headline)
                        .foregroundColor(.blue.opacity(0.5))
                        
                }
                .frame(width:60, height: 30)
                .background(Color.white.opacity(0.6))
                .mask(RoundedRectangle(cornerRadius: 30))
                .shadow(radius:10)
            }
            .padding()
        }
        .frame(width:UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
        .mask(RoundedRectangle(cornerRadius:20))
     
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Border"), lineWidth: 2))
        
    }
}







