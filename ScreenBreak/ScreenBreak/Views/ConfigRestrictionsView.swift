//
//  ConfigRestrictionsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import UserNotifications
import ManagedSettings
import WidgetKit

struct ConfigRestrictionsView: View {
    @ObservedObject var restrictionModel = MyRestrictionModel()
    @State private var showingRestrictionView = false
    @State private var showHelp = false
    @State private var scale = 0.1
    @AppStorage("endHour") private var endHour = 0
    @AppStorage("endMins") private var endMins = 0
    @AppStorage("inRestrictionMode") private var inRestrictionMode = false
    @AppStorage("widgetEndHour", store: UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")) private var widgetEndHour = 0
    @AppStorage("widgetEndMins", store: UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")) private var widgetEndMins = 0
    @AppStorage("widgetInRestrictionMode", store: UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")) private var widgetInRestrictionMode = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-Bold", size: 40)!]

        }
    
    
    // Main View for Restrictions page
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor").edgesIgnoringSafeArea(.all)
                if(inRestrictionMode) {
                    restrictionView
                        .blur(radius: showHelp ? 30: 0)
                } else {
                    baseView
                        .blur(radius: showHelp ? 30: 0)
                    
                }
                
                if showHelp{
                    tutorialRestrictions
                        .scaleEffect(scale)
                        .onAppear{
                            withAnimation(.easeInOut(duration: 0.3)) {
                                scale = 1.1
                            }
                        }
                }
                
            }.onAppear(perform: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
                // Check current time to see if user was in restrictions mode
               checkForRestrictionMode()
                
            }).onDisappear(perform: {
                // Check current time to see if user was in restriction mode
                checkForRestrictionMode()
            })
            .navigationTitle("Restrictions")
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
        .navigationViewStyle(.stack)
    }
    
    var tutorialRestrictions: some View{
        ZStack{
            Color(.lightGray).opacity(0.7)
            VStack(alignment:.center){
                Text("Restriction mode enables you to designate which applications you wish to impose limitations upon, along with the precise duration of their restricted usage. Subsequently, shields will be deployed to enforce the set restrictions until the expiration of the designated time frame, at which point they will be lifted. Exercise discretion in your selection!")
                    .customFont(.subheadline)
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
        .frame(width:UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.45)
        .mask(RoundedRectangle(cornerRadius:20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Border"), lineWidth: 2))
        
    }
    
    // Create view that will render when in restriction mode
    var restrictionView: some View{
        VStack() {
            Spacer()
            VStack {
                Text("You're Currently in Restriction Mode").customFont(.title)
                HStack {
                    Text("Your apps will unlock at").customFont(.subheadline)
                    Text("\(formatTime(hours: endHour, minutes: endMins))")
                        .customFont(.subheadline)
                }
            }
            Spacer()
            Spacer()
            Text("Restricted Apps + Categories ").customFont(.title3)
            List {
                Section {
//                    ForEach(Array(MyModel.shared.savedSelection)){ entity in
//                        Text(entity.name ?? "NO NAME")
//                    }
                    ForEach(Array(MyModel.shared.selectionToDiscourage.applicationTokens), id: \.self) {token in
                        HStack {
                            Label(token).customFont(.body)
                        }
                        
                    }
                    ForEach(Array(MyModel.shared.selectionToDiscourage.categoryTokens), id: \.self) {token in
                        Label(token).labelStyle(.iconOnly)
                    }
                }
                
            }.background(Color(.clear))
        }.padding()
    }
    
    // Create view that will render when there are no current restrictions
    var baseView: some View{
        VStack(alignment: .center) {
            Spacer()
            Text("Need a break from the apps?").customFont(.largeTitle).multilineTextAlignment(.center).bold()
            Text("Tap to enter Restriction Mode!").customFont(.title3).multilineTextAlignment(.center)
            Button(action: {showingRestrictionView.toggle()}){
                Image("appLogo").resizable().frame(width: 200, height:200)
            }.shadow(color: Color("Shadow"), radius: 10)
                .sheet(isPresented: $showingRestrictionView) {
                RestrictionView(restrictionModel: restrictionModel).presentationDetents([.medium])
            }
            Spacer()
        }
        .padding()
    }
    
    // Update Restriction Mode
    func checkForRestrictionMode() -> Void {
        let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
        let curHour = hourComponents.hour ?? 0
        
        let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
        let curMins = minuteComponents.minute ?? 0

        if(curHour > endHour){
            widgetInRestrictionMode = false
            inRestrictionMode = false
            MyModel.shared.deleteAllApps()
            WidgetCenter.shared.reloadAllTimelines()
        } else if(curHour == endHour && curMins >= endMins){
            widgetInRestrictionMode = false
            inRestrictionMode = false
            MyModel.shared.deleteAllApps()
            WidgetCenter.shared.reloadAllTimelines()
        }
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
