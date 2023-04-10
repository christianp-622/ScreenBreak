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
                VStack(alignment: .leading) {
                    Spacer()
                    VStack {
                        Text("You're Currently in Restriction Mode").customFont(.title).multilineTextAlignment(.center).bold()
                        HStack {
                            Text("Your apps will unlock at ").font(.title3)
                            Text("\(formatTime(hours: self.restrictionModel.endHour, minutes: self.restrictionModel.endMins))")
                        }
                    }.padding()
                    Spacer()
                    Spacer()
                    //Text("Restricted Apps:").font(.title2)
                    List {
                        Section {
                            ForEach(Array(MyModel.shared.selectionToDiscourage.applicationTokens), id: \.self) {token in
                                Label(token).padding()
                            }
                        } header: {
                            Text("Restricted Apps")
                        }.headerProminence(.increased)
                        
                        
                    }.background(Color("backgroundColor"))
                }.padding()
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Need a break from the apps?").font(.title).multilineTextAlignment(.center).bold()
                    Button(action: {showingRestrictionView.toggle()}){
                        HStack {
                            VStack(alignment: .leading){
                                Text("Enter Restriction Mode")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                            Image("appLogo").resizable().frame(width: 100, height:100)
                        }.padding()
                        
                    }.background(RoundedRectangle(cornerRadius: 30)
                        .fill(Color("backgroundColor"))
                        .shadow(color: .white, radius: 5))
                        .popover(isPresented: $showingRestrictionView, arrowEdge: .bottom) {
                        RestrictionView(restrictionModel: restrictionModel)
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
        .navigationViewStyle(.stack)
    }
}

struct RestrictionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isDiscouragedPresented = false
    @ObservedObject var restrictionModel: MyRestrictionModel
    @EnvironmentObject var model: MyModel
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    @State private var restrictionDuration = "15 mins"
    @State private var showAlert = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                HStack{
                    HStack{
                        Button("Cancel") {
                            dismiss()
                        }.font(.subheadline)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Button("Start Restrictions") {
                            if(MyModel.shared.selectionToDiscourage.applicationTokens.count == 0) {
                                showAlert = true
                            } else {
                                showAlert = false
                                self.restrictionModel.inRestrictionMode = true
                                let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
                                let curHour = hourComponents.hour ?? 0
                                
                                let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
                                let curMins = minuteComponents.minute ?? 0
                                
                                self.restrictionModel.startMin = curMins
                                self.restrictionModel.startHour = curHour
                                
                                switch restrictionDuration {
                                case "15 mins":
                                    let endTime = getEndTime(hourDuration: 0, minuteDuration: 15)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "30 mins":
                                    let endTime = getEndTime(hourDuration: 0, minuteDuration: 30)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "1 hour":
                                    let endTime = getEndTime(hourDuration: 1, minuteDuration: 0)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "1 hour 30 mins":
                                    let endTime = getEndTime(hourDuration: 1, minuteDuration: 30)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "2 hours":
                                    let endTime = getEndTime(hourDuration: 2, minuteDuration: 0)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "2 hours 30 mins":
                                    let endTime = getEndTime(hourDuration: 2, minuteDuration: 30)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "3 hours":
                                    let endTime = getEndTime(hourDuration: 3, minuteDuration: 0)
                                    self.restrictionModel.endHour = endTime[0]
                                    self.restrictionModel.endMins = endTime[1]
                                case "Rest of Day":
                                    self.restrictionModel.endHour = 23
                                    self.restrictionModel.endMins = 59
                                default:
                                    print("Have you done something new?")
                                }
                                MySchedule.setSchedule(endHour: self.restrictionModel.endHour, endMins: self.restrictionModel.endMins)
                                dismiss()
                            }
                        }.foregroundColor(.blue)
                            .font(.subheadline)
                            .bold()
                            .lineLimit(1)
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("No Apps Selected"),
                                    message: Text("Please select apps before starting Restriction Mode.")
                                )
                            }
                        
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text(MyModel.shared.selectionToDiscourage.applicationTokens.count > 0 ? "\(MyModel.shared.selectionToDiscourage.applicationTokens.count) Selected Apps: " : "No Apps Selected").font(.title).bold()
                if(MyModel.shared.selectionToDiscourage.applicationTokens.count > 0 ){
                    ScrollView(.vertical) {
                        LazyVGrid(columns:columns, spacing: 10) {
                            ForEach(Array(MyModel.shared.selectionToDiscourage.applicationTokens), id: \.self) { app in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(.clear)
                                        .shadow(radius: 10)
                                        .shadow(radius: 10)
                                    VStack {
                                        Label(app)
                                            .labelStyle(.iconOnly)
                                            .shadow(radius: 2)
                                            .scaleEffect(3)
                                            .frame(width:50, height:50)
                                        
                                    }
                                    .padding()
                                    .multilineTextAlignment(.center)
                                }
                                .frame(width: 100, height:100)
                                .padding()
                            }
                        }.padding()
                    }.frame(width: UIScreen.main.bounds.width * 0.9, height:200)
                }
                Button(action: {isDiscouragedPresented = true}) {
                    Label("Select Apps to Restrict", systemImage: "lock.fill")
                        .foregroundColor(.blue)
                        .customFont(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(3)
                        .backgroundStyle(.thinMaterial)
                }.familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                Spacer()
                Label("Selected Duration: \(restrictionDuration)", systemImage: "clock")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(3)
                    .backgroundStyle(.thinMaterial)
                // Time Options: 30mins, 1 hour, 1 hour 30mins, 2 hours, 2.5 hours, 3 hours, End Of Day
                Picker("Select Your Restriction Time", selection: $restrictionDuration) {
                    ForEach(["15 mins","30 mins", "1 hour", "1 hour 30 mins", "2 hours", "2 hours 30 mins", "3 hours", "Rest Of Day"], id: \.self) { time in
                        Text("\(time)")
                    }
                }.pickerStyle(.wheel)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height:150)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(.thinMaterial)
                        .shadow(color: .white, radius: 10))
                Spacer()
            }.padding()
        }
        .font(.title)
        .padding()
        .background(Color("backgroundColor"))
    }
        
        
}

func getEndTime(hourDuration: Int, minuteDuration: Int) -> [Int] {
    let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
    let curHour = hourComponents.hour ?? 0
    
    let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
    let curMins = minuteComponents.minute ?? 0
        
    
    var endMins = minuteDuration + curMins
    var endHour = hourDuration + curHour
    
    if(endMins >= 60) {
        endMins -= 60
        endHour += 1
    }
    
    if(endHour > 23) {
        endHour = 23
        endMins = 59
    }
        
    return [endHour, endMins]
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
    //@Published var dateSet = 0
    @Published var startHour = 0
    @Published var startMin = 0
    @Published var endHour = 0
    @Published var endMins = 0
    @Published var startTime = ""
    @Published var endTime = ""
    
    
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
