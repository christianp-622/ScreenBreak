//
//  HomeView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import SwiftUICharts
import RiveRuntime
import DeviceActivity

struct HomeView: View {
    
    @State private var topThreecontext: DeviceActivityReport.Context = .init(rawValue: "Top Three Apps")
    @State private var categoryContext: DeviceActivityReport.Context = .init(rawValue: "Total Category")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    @EnvironmentObject var model: MyModel
    let button = RiveViewModel(fileName: "button")
    @State private var isDiscouragedPresented = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

        }
    

    var body: some View {
        NavigationView {
            VStack {
                DeviceActivityReport(categoryContext, filter: filter)
                DeviceActivityReport(topThreecontext, filter: filter)
              //  AnimatedButton()
                button.view()
                    .frame(width: 236, height:64)
                    .overlay(
                        Label("Select Apps to Lock", systemImage:"lock.fill")
                            .offset(x:4, y: 4)
                            .customFont(.headline)
                            .foregroundColor(Color(.darkGray))
                    )
                    .background(
                        Color.black
                            .cornerRadius(30)
                            .blur(radius:10)
                            .opacity(0.3)
                            .offset(y:10)
                    )
                    .onTapGesture{
                        button.play(animationName:"active")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isDiscouragedPresented.toggle()
                        }
                    }
                    .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                
               
                    
                
                Spacer(minLength:80)
                
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .navigationBarTitle("Home")
            .onChange(of: model.selectionToDiscourage) { newSelection in
                    MyModel.shared.setShieldRestrictions()}
        }
        .navigationViewStyle(.stack)
        
    }

}

struct AnimatedButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            // Action to perform when the button is pressed
        }) {
            Text("Press Me")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(isPressed ? Color.red.opacity(0.7) : Color.red)
                .cornerRadius(10)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .animation(.spring())
        }
        .onLongPressGesture(minimumDuration: 0.2, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.3)) {
                self.isPressed = pressing
            }
        }) {
            // Action to perform when the long press gesture ends
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
