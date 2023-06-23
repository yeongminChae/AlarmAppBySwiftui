//
//  AlarmBox.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/18.
//

import SwiftUI

struct AlarmBox: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @State var isToggled:[Bool]

    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
        let alarmCount = alarmVM.alarms?.count
        _isToggled = State(initialValue: Array(repeating: true, count: alarmCount ?? 0))
    }

    var body: some View {
        
        if let alarms = alarmVM.alarms?.sorted(by: {$0.alarmTime < $1.alarmTime}) {
            VStack(alignment: .center, spacing: 10) {
                ForEach(alarms.indices, id: \.self) { i in
                    let alarm = alarms[i]
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 28).frame(width: 358, height: 112).foregroundColor(!isToggled[i] ? Color(hex: "D8E9E7") : Color(.white))
                        VStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 9).frame(width: 52, height: 21).foregroundColor(!isToggled[i] ? Color(hex: "B7CAC8") : Color(hex: "4FCCBC"))
                                    .overlay(
                                        Text("\(String(alarm.duration))mins").font(.system(size: 11, weight: .semibold)).foregroundColor(.white)
                                    )
                                RoundedRectangle(cornerRadius: 9).frame(width: 91, height: 21).foregroundColor(!isToggled[i] ? Color(hex: "F2F8F7") : Color(hex: "D4F5F1"))
                                    .overlay(
                                        Text(alarm.repeatDays.joined(separator: ", ")).font(.system(size: 11, weight: .semibold)).foregroundColor(!isToggled[i] ? Color(hex: "B7CAC8") : Color(hex: "04B69F"))
                                    )
                                Spacer()
                                Image(systemName: "ellipsis")
                                
                            }.padding(.horizontal, 35).padding(.top, 5)
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text(alarm.alarmTime.components(separatedBy: " ")[1]).font(.system(size: 42, weight: .medium)).foregroundColor(!isToggled[i] ? Color(hex: "99ABA9") : .black)
                                Text(alarm.alarmTime.components(separatedBy: " ")[0]).font(.system(size: 28, weight: .semibold)).foregroundColor(!isToggled[i] ? Color(hex: "B7CAC8") : Color(hex: "4FCCBC"))
                                Spacer()
                                
                            }.padding(.horizontal, 35)
                            
                        }
                        
                        Toggle("", isOn: $isToggled[i]).toggleStyle(ToggleStyleCustom()).padding(.horizontal, 35).padding(.top, 50)
                    }
                    
                }
                
            }
        }
    }
}

struct AlarmBox_Previews: PreviewProvider {
    static var previews: some View {
        AlarmBox(alarmVM: AlarmViewModel())
    }
}
