//
//  AlarmRow.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/24.
//

import SwiftUI

struct AlarmRow: View {
    let alarm: Alarm
    @Binding var isToggled: Bool
    @Binding var showOptions: Bool
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 9).frame(width: 52, height: 21).foregroundColor(!isToggled ? Color(hex: "B7CAC8") : Color(hex: "4FCCBC"))
                .overlay(
                    AlarmViewTextFormat(contents:"\(String(alarm.duration))mins", fontSize: 11, fontWeight: .semibold)
                        .foregroundColor(.white)
                )
            RoundedRectangle(cornerRadius: 9).frame(width: 91, height: 21).foregroundColor(!isToggled ? Color(hex: "F2F8F7") : Color(hex: "D4F5F1"))
                .overlay(
                    AlarmViewTextFormat(contents: alarm.repeatDays.joined(separator: ", "), fontSize: 11, fontWeight: .semibold)
                        .foregroundColor(!isToggled ? Color(hex: "B7CAC8") : Color(hex: "04B69F"))
                )
            Spacer()
            
            ZStack {
                Image(systemName: "ellipsis")
                    .onTapGesture {
                        showOptions.toggle()
                    }
                if showOptions {
                    EllipsisView(alarm, alarmVM: AlarmViewModel())
                }
                Spacer()
            }

        }.padding(.horizontal, 35).padding(.top, 5)
    }
}
