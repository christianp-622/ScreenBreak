//
//  CardView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/29/23.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct CardView: View {
    let app: AppDeviceActivity
    let disablePopover:Bool
    
    @State private var showInfo = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.clear)
                .shadow(radius: 10)
                .shadow(radius: 10)
            
            VStack {
                Label(app.token)
                    .labelStyle(.iconOnly)
                    .frame(width:50, height:50)
                    .shadow(radius: 2)
                    .scaleEffect(3)
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style:.continuous)
                               .stroke(.black, lineWidth: 2)
                       )
                    
                   
                    
                Text(app.displayName)
                    .customFont(.subheadline2)
                    .scaledToFill()
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 100, height:100)
        
        
        .padding()
        .onTapGesture{
            if !disablePopover {
                showInfo.toggle()
            }
        }
        .popover(isPresented: $showInfo, arrowEdge: .bottom) {
            CardViewPopup(app:app)
        }
    }
}

struct CardViewPopup: View {
    let app: AppDeviceActivity
    var body: some View {
        VStack{
            Label(app.token)
                .labelStyle(.iconOnly)
                .shadow(radius: 5)
                .scaleEffect(3)
                .frame(width:50, height:50)
            Text(app.displayName)
                .customFont(.title2)
            Spacer()
            HStack {
                Text("Application Category:")
                    .customFont(.subheadline)
                Text("\(app.category)")
                    .customFont(.subheadline2)
                }
            Spacer()
            HStack {
                Text("Total Application Pickups:")
                    .customFont(.subheadline)
                Text("\(app.numberOfPickups)")
                    .customFont(.subheadline2)
                }
            Spacer()
            HStack {
                Text("Total Number of Notifications:")
                    .customFont(.subheadline)
                Text("\(app.numberOfNotifs)")
                    .customFont(.subheadline2)
                }
            Spacer()
            HStack {
                Text("Screen Time:")
                    .customFont(.subheadline)
                Text("\(app.duration)")
                    .customFont(.subheadline2)
                }
        }
        .fixedSize()
        //.frame(width: .infinity, height: 200)
    }
}
