//
//  UpcomingTopPart.swift
//  
//
//  Created by 채영민 on 2023/06/18.
//

import SwiftUI

struct UpcomingTopPart: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @State var isToggled:[Bool]
    
    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
        let alarmCount = alarmVM.alarms?.count
        _isToggled = State(initialValue: alarmVM.alarms?.map({ $0.toggle }) ?? [])
    }
    
    var body: some View {
        ZStack {
            if let alarms = alarmVM.alarms, !alarms.isEmpty, let firstAlarm = alarms.first {
                
                Image("UpcomingBoxTop").padding(.top, -0.3).overlay(
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 9).frame(width: 52, height: 21)
                            .foregroundColor(Color(hex: "4FCCBC"))
                            .overlay(
                                AlarmViewTextFormat(contents:"\(String(firstAlarm.duration))mins", fontSize: 11, fontWeight: .semibold)
                                    .foregroundColor(.white)
                            )
                        RoundedRectangle(cornerRadius: 9).frame(width: 91, height: 21)
                            .foregroundColor(.white)
                            .overlay(
                                AlarmViewTextFormat(contents: firstAlarm.repeatDays.joined(separator: ", "), fontSize: 11, fontWeight: .semibold)
                                    .foregroundColor(Color(hex: "2BB8A6"))
                            )
                        Spacer()
                        Image(systemName: "ellipsis")
                        
                    }
                        .padding(.horizontal, 15)
                )
            } else {
                Text("No alarms yet").padding(.top, 250)
            }
        }
        .onAppear{
            alarmVM.refreshAlarms()
        }
        
    }
}

