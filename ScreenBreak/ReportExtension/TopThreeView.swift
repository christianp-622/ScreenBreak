//
//  TopThreeView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 4/2/23.
//

import SwiftUI


 struct TopThreeView: View {
     var topThreeReport: TopThreeReport
     private let fixedColumns =  [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
     let colors = [Color.cyan, .indigo, .pink, .purple, .yellow, .teal]
     
     var body: some View {
         ZStack {
             Color("backgroundColor")
                 .edgesIgnoringSafeArea(.all)
             HStack{
                 Spacer()
                 ZStack{
                     AngularGradient(colors: colors, center: .topLeading, angle:.degrees(180))
                     LinearGradient(gradient: Gradient(colors:[Color.white.opacity(0.3), Color.white.opacity(0.8)]), startPoint:.top, endPoint: .trailing)
                     card
                 }
                 Spacer()
             }
             .frame(width: UIScreen.main.bounds.width * 0.9, height:200)
             .mask(RoundedRectangle(cornerRadius:40, style:.continuous))
             .overlay(RoundedRectangle(cornerRadius:40, style:.continuous).stroke(.black, lineWidth: 2))
             .shadow(radius: 5)
             .padding(30)
         .background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), startPoint: .top, endPoint: .bottom))
         }
     }
     
     var card: some View{
         VStack(alignment:.center){
             Spacer()
             Text("Top Apps")
                 .customFont(.title)
             Rectangle()
                 .fill(.black)
                 .frame(width:100, height: 3)
                 .edgesIgnoringSafeArea(.horizontal)
             
             LazyVGrid(columns:fixedColumns, spacing:5){
                 ForEach(topThreeReport.apps){ app in
                     CardView(app:app, disablePopover: true)
                 }
             }
         }
         .padding(30)
     
     }
 }
 
