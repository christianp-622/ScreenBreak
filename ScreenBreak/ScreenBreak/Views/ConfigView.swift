//
//  ConfigView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import RiveRuntime
import FamilyControls

struct ConfigView: View {

    var body: some View {
        NavigationView {
            ZStack{
                Color("backgroundColor")
                
                    
                Button("Select Apps to Discourage"){
                    print("hello")
                }
            }
            .edgesIgnoringSafeArea(.all)

        }
        .navigationViewStyle(.stack)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
