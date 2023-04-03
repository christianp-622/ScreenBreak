//
//  TopThreeView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 4/2/23.
//

import SwiftUI

struct TopThreeView: View {
    var topThreeReport: TopThreeReport
    private let adaptiveColumns = [GridItem(.adaptive(minimum:50))]
    private let fixedColumns =  [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
    let colors = [Color.pink, .indigo, .pink, .mint, .purple, .yellow, .mint]
    
    var body: some View {
        HStack{
            Spacer()
            card
            Spacer()
        }
    }
    
    var card: some View{
        
        VStack(alignment:.center){
            Text("Top Apps")
                .font(.system(size: 36))
                .font(.headline)
               
            LazyVGrid(columns:fixedColumns, spacing:10){
                ForEach(topThreeReport.apps){ app in
                    CardView(app:app)
                }
            }
        }
        .padding(30)
        .background(AngularGradient(colors: colors, center: .topLeading)
        .edgesIgnoringSafeArea(.all))
        //.background(.linearGradient(colors:[.mint, .mint.opacity(0.2)], startPoint:.topLeading, endPoint:.bottomTrailing))
        .mask(RoundedRectangle(cornerRadius:40, style:.continuous))
        .shadow(color:.accentColor.opacity(0.3), radius:2, x:1, y:8)
        .shadow(color:.accentColor.opacity(0.3), radius:2, x:0, y:1)
    }
}
