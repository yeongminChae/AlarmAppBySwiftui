//
//  AddAlarmHeader.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import SwiftUI

struct AddAlarmHeader: View {
    let title:String
    
    var body: some View {
        ZStack {
            Rectangle().frame(height: 56).foregroundColor(Color(hex: "E1EDEC"))
            HStack(spacing: 120) {
                Image("")
                Text("\(title) Alarm")
                    .padding(.leading)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(hex: "04B69F"))
                
                Image(systemName: "questionmark.circle.fill").foregroundColor(Color(hex: "4FCCBC"))
            }
        }
    }
}
