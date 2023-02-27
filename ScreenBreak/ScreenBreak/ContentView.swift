//
//  ContentView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 2/26/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack{
                //totalTime()
                topApps()
                biggestLosers()
                Button("Set Time Limits"){
                    print("hello world")
                }
                
            }
            .padding()
            
            .navigationBarTitle("ScreenBreak")
            .navigationBarItems(trailing:
                Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                )
             
        }
    }
  
    

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct totalTime: View {
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                Text("Total Time")
                    .font(.headline)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                Image("totalTime")
                    .resizable()
                    .scaledToFit()
                    .frame(width:350, height: 250)
                    
            }
            .padding()
        }
    }
}



struct topApps: View {
    var body: some View {
        NavigationView{
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 3)
                    .padding()
                    
                VStack(alignment: .leading){
                    Text("Top Apps")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.black, lineWidth: 2)
                            .padding()
                            .frame(width:325, height:125)
                            
                        
                        HStack {
                            VStack {
                                Image("cocLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text("Clash of Clans")
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        
                        
                            VStack {
                                Image("youtubeLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text("Youtube")
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        
                        
                            VStack {
                                Image("instaLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text("Instagram")
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        }
                        .padding()
                        
                    }
                }
            }
        }
    }
}

struct biggestLosers: View {
    var body: some View {
        NavigationView{
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .stroke(Color.black, lineWidth: 3)
                    .padding()
                    
                    
                VStack(alignment: .leading){
                    Text("Biggest Losers")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.black, lineWidth: 2)
                            .padding()
                            .frame(width:325, height:125)
                        
                        
                    
                        HStack {
                            VStack {
                                Image("candyLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text("Candy Crush")
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        
                        
                            VStack {
                                Image("brawlLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text("Brawl Stars")
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        
                        
                            VStack {
                                Image("tiktokLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text("Tik Tok")
                                    .font(.caption)
                                    .bold()
                            }
                            .padding()
                        }
                        .padding()
                    }
                }
                
                
            }
        }
    }
}



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
