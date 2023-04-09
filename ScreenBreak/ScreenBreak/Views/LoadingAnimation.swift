//
//  LoadingAnimation.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 4/6/23.
//

import SwiftUI

struct LoadingAnimation: View {
    @State private var animationAmount = 0.0
//    @Binding var isPresented: Bool
    
    var body: some View {
        
        HStack {
            ForEach(0..<3){index in
                Circle()
                    .frame(width:25, height:25)
                    .scaleEffect(animationAmount)
                    .opacity(Double(3 - index) / 3)
                    .animation(Animation.easeInOut(duration:1.5).repeatForever(autoreverses:true)
                        .delay(0.25 * Double(index)), value: animationAmount)
            }
            .onAppear{
                animationAmount = 1
            }
        }
    }
}


struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
