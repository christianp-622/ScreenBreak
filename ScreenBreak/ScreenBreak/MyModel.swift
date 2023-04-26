//
//  MyModel.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/27/23.
//

import Foundation
import FamilyControls
import ManagedSettings
import CoreData

private let _MyModel = MyModel()

class MyModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    let store = ManagedSettingsStore()
    let container: NSPersistentContainer
    //@EnvironmentObject var store: ManagedSettingsStore
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var selectionToEncourage: FamilyActivitySelection
    @Published var savedSelection: [AppEntity] = []
    
    init() {
        container = NSPersistentContainer(name:"ApplicationsContainer")
        container.loadPersistentStores{(description, error) in
            if let error = error{
                print("ERROR LOADING CORE DATA. \(error)")
            }else{
                print("Successfully loaded core data.")
            }
            
        }
        selectionToDiscourage = FamilyActivitySelection()
        selectionToEncourage = FamilyActivitySelection()
        fetchApps()
    }
    
    func fetchApps(){
        let request = NSFetchRequest<AppEntity>(entityName: "AppEntity")
        do{
            savedSelection = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func addApp(name: String){
        let newApp = AppEntity(context: container.viewContext)
        newApp.name = name
        saveData()
    }
    
    func deleteAllApps(){
        for entity in savedSelection{
            container.viewContext.delete(entity)
        }
        saveData()
    }
    
    func saveData() {
        do{
            try container.viewContext.save()
            fetchApps()
        } catch let error{
            print("Error saving. \(error)")
        }
    }
    
    
    class var shared: MyModel {
        return _MyModel
    }
    
    func setShieldRestrictions() {
        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = MyModel.shared.selectionToDiscourage
        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
}
