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
                    .shadow(radius: 2)
                    .scaleEffect(3)
                    .frame(width:50, height:50)
                    
                Text(app.displayName)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 100, height:100)
        .padding()
        .onTapGesture{
            showInfo.toggle()
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
                .font(.system(size: 36))
            Spacer()
            Text("Application Category: **\(app.category)**")
            Spacer()
            Text("Total Application Pickups: **\(app.numberOfPickups)**")
            Spacer()
            Text("Total Number of Notifications: **\(app.numberOfNotifs)**")
            Spacer()
            Text("Screen Time: **\(app.duration)**")
        }
        .fixedSize()
        //.frame(width: .infinity, height: 200)
    }
}
