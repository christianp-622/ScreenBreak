//
//  ConfigView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import UserNotifications
import RiveRuntime

struct ConfigView: View {
    @ObservedObject var restrictionModel = MyRestrictionModel()
    let button = RiveViewModel(fileName: "button")
    @State private var showingRestrictionView = false
    
    var body: some View {
        NavigationView {
            if(self.restrictionModel.inRestrictionMode) {
                VStack() {
                    Spacer()
                    VStack {
                        Text("You're Currently in Restriction Mode").customFont(.title)
                        HStack {
                            Text("Your apps will unlock at").customFont(.subheadline)
                            Text("\(formatTime(hours: self.restrictionModel.endHour, minutes: self.restrictionModel.endMins))")
                                .customFont(.subheadline)
                        }
                    }
                    Spacer()
                    Spacer()
                    Text("Restricted Apps + Categories ").customFont(.title3)
                    List {
                        Section {
                            ForEach(Array(MyModel.shared.selectionToDiscourage.applicationTokens), id: \.self) {token in
                                HStack {
                                    Label(token).customFont(.body)
                                }
                                
                            }
                            ForEach(Array(MyModel.shared.selectionToDiscourage.categoryTokens), id: \.self) {token in
                                Label(token).labelStyle(.iconOnly)
                            }
                        }
                        
                    }.background(Color("backgroundColor"))
                }.padding()
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Need a break from the apps?").customFont(.largeTitle).multilineTextAlignment(.center).bold()
                    Text("Tap to enter Restriction Mode!").customFont(.title3).multilineTextAlignment(.center)
                    Button(action: {showingRestrictionView.toggle()}){
                        Image("appLogo").resizable().frame(width: 300, height:300)
                    }.shadow(color: .white, radius: 30)
                        .sheet(isPresented: $showingRestrictionView) {
                        RestrictionView(restrictionModel: restrictionModel).presentationDetents([.medium])
                    }
                    Spacer()
                }.padding()
            }
        }.onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
            let curHour = hourComponents.hour ?? 0
            
            let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
            let curMins = minuteComponents.minute ?? 0

            if(curHour > self.restrictionModel.endHour){
                self.restrictionModel.inRestrictionMode = false
            } else if(curHour == self.restrictionModel.endHour && curMins >= self.restrictionModel.endMins){
                self.restrictionModel.inRestrictionMode = false
            }
            
        }).onDisappear(perform: {
            let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
            let curHour = hourComponents.hour ?? 0
            
            let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
            let curMins = minuteComponents.minute ?? 0

            if(curHour > self.restrictionModel.endHour){
                self.restrictionModel.inRestrictionMode = false
            } else if(curHour == self.restrictionModel.endHour && curMins >= self.restrictionModel.endMins){
                self.restrictionModel.inRestrictionMode = false
            }
        })
        .background(Color("backgroundColor"))
        .navigationViewStyle(.stack)
    }
}


func formatTime(hours: Int, minutes: Int) -> String {
    var h = "\(hours)"
    var m = "\(minutes)"
    var pm = false
    if(hours % 12 > 0){
        h = "\(hours % 12)"
        pm = true
    }
    if(hours == 12){
        pm = true
    }
    if(minutes < 10){
        m = "0\(minutes)"
    }
    
    if(pm) {
        return "\(h):\(m) PM"
    } else {
        return "\(h):\(m) AM"
    }
}

class MyRestrictionModel: ObservableObject {
    @Published var inRestrictionMode = false
    @Published var startHour = 0
    @Published var startMin = 0
    @Published var endHour = 0
    @Published var endMins = 0
    @Published var startTime = ""
    @Published var endTime = ""
}
