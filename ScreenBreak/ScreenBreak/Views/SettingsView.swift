//
//  SettingsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack{
                    VStack(alignment:.leading){
                        ZStack{
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.ultraThickMaterial)
                                .frame(height: 200)
                                .shadow(radius: 10)
                            HStack{
                                VStack{
                                    Image("Profile").resizable().scaledToFit().frame(width: 150, height: 150)
                                    Text("Display Name").font(.subheadline)
                                    
                                }
                                VStack{
                                    Button("Change Profile Picture"){}.buttonStyle(.bordered)
                                    Button("Change Display Name"){}.buttonStyle(.bordered)
                                }
                            }.padding()
                        }.padding()
                        ZStack{
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.ultraThickMaterial)
                                .frame(height: 600)
                                .shadow(radius: 10)
                            VStack(alignment: .center){
                                Text("Friend Requests").font(.title2)
                                Divider()
                                VStack(alignment: .center){
                                    Text("No Current Requests").font(.title3)
                                }.padding()
                                Spacer()
                            }.padding()
                        }.padding()
                        
                    }
                }.navigationTitle("Settings")
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
