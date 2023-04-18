//
//  OnboardingView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 4/13/23.
//

import SwiftUI
import RiveRuntime
import ManagedSettings
import CoreData

struct OnboardingView: View {
    @AppStorage("showOnboarding") var showOnboarding = true
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    var body: some View {
       onboardingView
        .onAppear{
           DispatchQueue
               .main
               .asyncAfter(deadline:.now() + 5){
                   launchScreenManager.dismiss()
               }

       }
    }

    var onboardingView:some View{
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            RiveViewModel(fileName: "shapes").view()
                .ignoresSafeArea()
                .blur(radius:30)
                .background(
                    Image("Spline")
                        .blur(radius:60)
                        .offset(x:200, y:100)
                )
            
            ZStack {
                RoundedRectangle(cornerRadius:40,style:.circular).fill(Color("onboardingCard"))
                
                VStack{
                    Image(systemName:"clock")
                        .resizable()
                        .frame(width:100, height:100)
                    Text("Welcome to ScreenBreak! ")
                        .customFont(.title3)
                    Spacer()
                        .frame(height:30)
                    Text("You will have the ability to :")
                        .customFont(.headline)
                    Spacer()
                        .frame(height:10)
                    VStack{
                        Text("- Gain insights for your device activity")
                            .customFont(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("- View visial displays of information")
                            .customFont(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("- Lock any application(s) of your choosing for a specified time period")
                            .customFont(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width*0.7)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                        .frame(height:40)
                    
                    Button{
                        showOnboarding = false
                    }label: {
                        Text("Begin Insights")
                            .customFont(.headline)
                        
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.42, height: 40)
                    .background(Color("onboardingCard").opacity(0.9))
                    .mask(RoundedRectangle(cornerRadius:5))
                    .shadow(color:Color("Shadow"),radius:3)
                    .padding()
                }
            }
            .frame(width:UIScreen.main.bounds.width * 0.8, height:500)
            .mask(RoundedRectangle(cornerRadius:40))
            .shadow(color: Color("Shadow"), radius:5, x:2, y:3)
            .overlay(RoundedRectangle(cornerRadius: 40, style: .continuous)
                .stroke(.linearGradient(colors:[.white.opacity(0.2), .gray.opacity(0.8)], startPoint:.topLeading, endPoint: .bottomTrailing))
            )
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
