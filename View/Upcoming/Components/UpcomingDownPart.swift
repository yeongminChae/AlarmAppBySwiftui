//
//  UpcomingDownPart.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/18.
//

import SwiftUI

struct UpcomingDownPart: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @State var isToggled:Bool = true
    
    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
    }
    
    var body: some View {
        ZStack{
            if let alarms = alarmVM.alarms, !alarms.isEmpty, let firstAlarm = alarms.first {
                
                HStack(alignment: .lastTextBaseline) {
                    
                    VStack(alignment: .leading) {
                        AlarmViewTextFormat(contents: "until", fontSize: 18, fontWeight: .semibold).foregroundColor(Color(hex: "04B69F"))
                        AlarmViewTextFormat(contents: alarms.first?.alarmTime.components(separatedBy: " ")[1] ?? "", fontSize: 42, fontWeight: .medium).foregroundColor(.black)
                    }
                    
                    AlarmViewTextFormat(contents: alarms.first?.alarmTime.components(separatedBy: " ")[0] ?? "", fontSize: 28, fontWeight: .semibold).foregroundColor(Color(hex: "04B69F"))
                    
                    Spacer()
                    
                    Toggle("", isOn: $isToggled).toggleStyle(ToggleStyleCustom()).offset(y: -5)
                }.padding(.horizontal, 15).padding(.bottom, 10)
            }
            else {
                Text("")
            }
            
        }
        .onAppear{
            alarmVM.refreshAlarms()
        }
    }
}
