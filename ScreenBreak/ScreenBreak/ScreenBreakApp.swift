//
//  ScreenBreakApp.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 2/26/23.
//

import SwiftUI
import DeviceActivity
import FamilyControls
import ManagedSettings

@main
struct ScreenBreakApp: App {
    let persistenceController = PersistenceController.shared
    let center = AuthorizationCenter.shared
    @StateObject var launchScreenManager = LaunchScreenManager()
    @StateObject var model = MyModel.shared
    @StateObject var store = ManagedSettingsStore()
    @State var show = false
    

    
    var body: some Scene {
        WindowGroup {
            ZStack{
                VStack{
                    if show {
                        ContentView().environmentObject(model)
                            .environmentObject(store)
                    }else{
                        STProgressView()
                    }
                    
                }.onAppear{
                    Task{
                        do{
                            try await center.requestAuthorization(for: FamilyControlsMember.individual)
                            show = true
                            
                        }catch{
                            //Handle error here
                        }
                    }
                }
                
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
                 
            }
            .environmentObject(launchScreenManager)
           
        }
    }
}

struct STProgressView: View {
    var body: some View {
        ProgressView {
            Text("Loading")
        }
    }
}
