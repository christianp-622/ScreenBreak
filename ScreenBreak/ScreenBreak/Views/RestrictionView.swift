//
//  RestrictionView.swift
//  ScreenBreak
//
//  Created by Mya Mahaley on 4/14/23.
//

import SwiftUI
import WidgetKit

struct RestrictionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isDiscouragedPresented = false
    @State private var isDurationPresented = false
    @ObservedObject var restrictionModel: MyRestrictionModel
    @EnvironmentObject var model: MyModel
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    @State private var restrictionDuration = "15 mins"
    @State private var noAppsAlert = false
    @State private var maxAppsAlert = false
    
    
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
                            if(MyModel.shared.selectionToDiscourage.applicationTokens.count == 0 && MyModel.shared.selectionToDiscourage.categoryTokens.count == 0) {
                                noAppsAlert = true
                                maxAppsAlert = false
                            } else if(MyModel.shared.selectionToDiscourage.applicationTokens.count >= 20) {
                                noAppsAlert = false
                                maxAppsAlert = true
                            } else {
                                noAppsAlert = false
                                maxAppsAlert = false
                                UserDefaults.standard.set(true, forKey: "inRestrictionMode")
                                UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(true, forKey:"widgetInRestrictionMode")
                                print("APPS SELECTED : \(MyModel.shared.selectionToDiscourage.applications.count)")
                                for i in MyModel.shared.selectionToDiscourage.applications {
                                    print(i)
                                    MyModel.shared.addApp(name:i.localizedDisplayName ?? "Temp")
                                }
                                
                                //UserDefaults.standard.set(MyModel.shared.selectionToDiscourage.categoryTokens, forKey: "lockedCategorie")
                                let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
                                let curHour = hourComponents.hour ?? 0
                                
                                let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
                                let curMins = minuteComponents.minute ?? 0
                                
                                self.restrictionModel.startMin = curMins
                                self.restrictionModel.startHour = curHour
                                
                                switch restrictionDuration {
                                case "15 mins":
                                    let endTime = getEndTime(hourDuration: 0, minuteDuration: 15)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "30 mins":
                                    let endTime = getEndTime(hourDuration: 0, minuteDuration: 30)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "1 hour":
                                    let endTime = getEndTime(hourDuration: 1, minuteDuration: 0)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "1 hour 30 mins":
                                    let endTime = getEndTime(hourDuration: 1, minuteDuration: 30)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "2 hours":
                                    let endTime = getEndTime(hourDuration: 2, minuteDuration: 0)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "2 hours 30 mins":
                                    let endTime = getEndTime(hourDuration: 2, minuteDuration: 30)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "3 hours":
                                    let endTime = getEndTime(hourDuration: 3, minuteDuration: 0)
                                    UserDefaults.standard.set(endTime[0], forKey: "endHour")
                                    UserDefaults.standard.set(endTime[1], forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[0], forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(endTime[1], forKey:"widgetEndMins")
                                case "Rest of Day":
                                    UserDefaults.standard.set(23, forKey: "endHour")
                                    UserDefaults.standard.set(59, forKey: "endMins")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(23, forKey:"widgetEndHour")
                                    UserDefaults(suiteName:"group.ChristianPichardo.ScreenBreak")!.set(59, forKey:"widgetEndMins")
                                default:
                                    print("Have you done something new?")
                                }
                                WidgetCenter.shared.reloadAllTimelines()
                                MySchedule.setSchedule(endHour: UserDefaults.standard.integer(forKey: "endHour"), endMins: UserDefaults.standard.integer(forKey: "endMins"))
                                dismiss()
                            }
                        }.foregroundColor(.blue)
                            .font(.subheadline)
                            .bold()
                            .lineLimit(1)
                            
                        
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text("Restriction Mode").customFont(.title3)

                Button {
                    isDurationPresented = true
                } label: {
                    HStack(){
                        Image(systemName: "clock")
                        Text("Duration Selection").customFont(.body)
                        Spacer()
                        Text(restrictionDuration).customFont(.body)
                        Image(systemName: "chevron.right")
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .tint(Color(.black.withAlphaComponent(0.6)))
                    .sheet(isPresented: $isDurationPresented, onDismiss: {
                        
                    }, content: {
                        DurationPickerView(restrictionModel: restrictionModel, isDurationPresented: $isDurationPresented, restrictionDuration: $restrictionDuration)
                    })
                
                Button {
                    isDiscouragedPresented = true
                } label: {
                    HStack(){
                        Image(systemName: "lock.fill")
                        Text("App Selection").customFont(.body)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .tint(Color(.black.withAlphaComponent(0.6)))
                    .sheet(isPresented: $isDiscouragedPresented, onDismiss: {
                        
                    }, content: {
                        FamilyPickerView(model: model, isDiscouragedPresented: $isDiscouragedPresented)
                    })
                Spacer()
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
                            ForEach(Array(MyModel.shared.selectionToDiscourage.categoryTokens), id: \.self) { app in
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
                Spacer()
            }.padding()
        }
        .font(.title)
        .padding()
        .background(Color("backgroundColor"))
        .interactiveDismissDisabled()
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
