//
//  HomeView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                
                Button("Set Time Limits"){
                    print("hello world")
                }.buttonStyle(.bordered)
                
            }
            .padding()
            .navigationBarTitle("ScreenBreak")
            .navigationBarItems(trailing:
                Image("appLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .padding()
                )
        }
        .navigationViewStyle(.stack)
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


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
