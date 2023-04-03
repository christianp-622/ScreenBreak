//
//  CreateProfileView.swift
//  ScreenBreak
//
//  Created by Moe Ghanem on 3/28/23.
//

import SwiftUI

struct CreateProfileView: View {
    
    private var profile_color: UIColor = UIColor.random
    @State private var user: String = ""
    @State private var name: String = ""
    
    var body: some View {
        
        VStack{
            ZStack{
                Circle()
                    .fill(Color(profile_color))
                    .scaledToFit()
                Text(user)
                    .foregroundColor(Color(profile_color.invert()))
                    .scaledToFit()
            }.frame(width: 100, height: 100)
            TextField("Username", text: $user)
                
                .padding(.vertical, 1.0)
            TextField("Name", text: $name)
                .padding(.vertical, 1.0)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
    func invert () -> UIColor {
            var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
            if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
                return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
            }
            return .black // Return a default color
            // https://stackoverflow.com/a/57111280
        }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}
