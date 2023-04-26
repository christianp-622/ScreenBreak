//
//  DurationPickerView.swift
//  ScreenBreak
//
//  Created by Mya Mahaley on 4/15/23.
//

import SwiftUI

struct DurationPickerView: View {
    @ObservedObject var restrictionModel: MyRestrictionModel
    @Binding var isDurationPresented: Bool
    @Binding var restrictionDuration: String
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Rectangle()
                .frame(width: 30, height: 3, alignment: .center)
                .cornerRadius(5)
                .foregroundColor(.black.opacity(0.5))
            Spacer()
            Text("Restriction Mode Duration Selection")
                .customFont(.title)
                .fontWeight(.bold)
                .font(.body)
            Spacer()
            Text("Please select your Restriction Mode Duration.")
                .multilineTextAlignment(.center)
            Spacer()
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.7))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                // Time Options: 15 mins, 30mins, 1 hour, 1 hour 30mins, 2 hours, 2.5 hours, 3 hours, End Of Day
                Picker("Select Your Restriction Time", selection: $restrictionDuration) {
                    ForEach(["15 mins","30 mins", "1 hour", "1 hour 30 mins", "2 hours", "2 hours 30 mins", "3 hours", "Rest Of Day"], id: \.self) { time in
                        Text("\(time)")
                    }
                }.pickerStyle(.wheel)
                    .padding(.all, 10)

            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.6, maxHeight: UIScreen.main.bounds.height * 0.35)
            Spacer()
            Button(action : {
                isDurationPresented = false
            }) {
                Text("Save").customFont(.title).foregroundColor(.blue)
            }
        }
        .font(.body)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(EdgeInsets(top: 8, leading: 15, bottom: 20, trailing: 15))
        .background(Color("backgroundColor"))
        .interactiveDismissDisabled()
    }
}
