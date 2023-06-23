//
//  AddAlarmBtn.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/21.
//

import SwiftUI

struct AddAlarmBtn: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var alarmVM: AlarmViewModel
    @StateObject private var repeatDaysSettings = RepeatDaysSettings()
    @StateObject private var alarmTimeSettings = AlarmTimeSettings()
    
    @State private var isTabbed: [Bool] = Array(repeating: false, count: 3)
    @State private var someToggle = true
    @State private var alarmTime = Date()
    @State private var repeatDays: [String] = []
    @State private var duration = 0
    @State private var mission = false
    
    var body: some View {
        ZStack {
            Button(action: {
                let alarm = Alarm()
                alarm.alarmTime = alarmTimeSettings.selectedTime
                for i in repeatDaysSettings.selectedDays {
                    alarm.repeatDays.append(String(i))
                }
                alarm.duration = duration
                alarm.mission = mission
                alarm.toggle = true
                
                alarmVM.addAlarm(alarm: alarm)
                self.presentationMode.wrappedValue.dismiss()
                
                NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
            }) {
                
                ZStack(alignment: .center) {
                    createContentBlock(title: "", height: 56, RecColor: repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? "4FCCBC" : "B7CAC8")
                        .animation(.easeInOut(duration: 0.3), value: repeatDaysSettings.selectedDays.isEmpty != true && duration != 0)
                    Text("Save")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "ffffff")).padding(.top, 10)
                }
            }
            .disabled(repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? false : true)
        }
        .environmentObject(repeatDaysSettings)
        .environmentObject(alarmTimeSettings)
    }
    func selectDuration(_ duration: Int) {
        for i in 0..<isTabbed.count {
            isTabbed[i] = ( i == durationIndex(for: duration))
        }
        self.duration = duration
    }
}
