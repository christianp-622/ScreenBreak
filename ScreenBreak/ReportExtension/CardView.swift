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
import CoreHaptics

struct HapticFeedback: ViewModifier {
  private let generator: UIImpactFeedbackGenerator

  init(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    generator = UIImpactFeedbackGenerator(style: style)
  }

  func body(content: Content) -> some View {
    content
      .onTapGesture(perform: generator.impactOccurred)
  }
}

extension View {
  func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) -> some View {
    self.modifier(HapticFeedback(style: style))
  }
}

extension Color{
    static let borderColor = Color("border")
}

struct CardView: View {
    let app: AppDeviceActivity
    let disablePopover:Bool
    
    @State private var tapped = false
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
                    .mask(RoundedRectangle(cornerRadius: 8, style:.continuous))
                        
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style:.continuous)
                            .stroke(Color.borderColor, lineWidth: 2)
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
        .scaleEffect(tapped ? 1.4 : 1)
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
        .onTapGesture{
            var temp = UIImpactFeedbackGenerator(style:.heavy)
            temp.impactOccurred()
            if !disablePopover{
                tapped.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    tapped.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    showInfo.toggle()
                }
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
