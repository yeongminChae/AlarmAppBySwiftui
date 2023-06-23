//
//  ToggleStyle.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import Foundation
import SwiftUI

struct ToggleStyleCustom: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(configuration.isOn ? Color(hex: "CBF1EC") : Color(hex: "F2F8F7"))
                    .frame(width: 46, height: 22, alignment: .center)
                    .cornerRadius(20)
                
                Circle()
                    .foregroundColor(configuration.isOn ? Color(hex: "4FCCBC") : Color(hex: "A9BDBB"))
                    .shadow(color: !configuration.isOn ? Color(hex: "99ABA9") : Color(hex: "4FCCBC"), radius: 5, x: 0, y: 2)
                    .frame(width: 34, height: 34)
                    .offset(x:configuration.isOn ? 13 : -13, y: 0)
                    .animation((Animation.easeInOut(duration: 0.2)), value: configuration.isOn)
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn.toggle()
                        }
                    }
            }
        }
    }
}
