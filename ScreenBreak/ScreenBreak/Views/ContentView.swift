//
//  ContentView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 2/26/23.
//

import SwiftUI
import CoreData
import FamilyControls

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var launchScreenManager: LaunchScreenManager


    var body: some View {
        TabBar()
            .onAppear{
                DispatchQueue
                    .main
                    .asyncAfter(deadline:.now() + 5){
                        launchScreenManager.dismiss()
                    }
            }
            
    }

}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(LaunchScreenManager())
    }
}
