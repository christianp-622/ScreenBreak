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
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ScreenBreakApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
                            .environment(\.managedObjectContext,persistenceController.container.viewContext)
                        
                    }else{
                        STProgressView()
                    }
                    
                }.onAppear{
                    Task{
                        do{
                            try await center.requestAuthorization(for: FamilyControlsMember.individual)
                            show = true
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                            
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
