//
//  AddAlarm.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI

struct AddAlarm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var alarmVM: AlarmViewModel
    
    @StateObject private var repeatDaysSettings = RepeatDaysSettings()
    @StateObject private var alarmTimeSettings = AlarmTimeSettings()

    @State var selectedPostDate: Date
    @State var selectedAlarmTime: String
    @State var selectedDuration: Int
    @Binding var selectRepeatedDays: [String]
    
    @State private var isTabbed: [Bool] = Array(repeating: false, count: 3)
    @State private var someToggle = true
    @State private var alarmTime = Date()
    @State private var repeatDays: [String] = []
    @State private var duration = 0
    @State private var mission = false
    
    let title: String
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color(hex: "F2F2F2")).ignoresSafeArea()
            VStack(spacing: 20) {
                AddAlarmHeader(title: title)
                Spacer()
                
                AddAlarmDatePicker(selectedAlarmTime: selectedAlarmTime).frame(height: 130)
                Spacer()
                
                ZStack {
                    createContentBlock(title: "REPEAT", height: 76, RecColor: "ffffff")
                    AddAlarmRepeatBanner(selectRepeatedDays: selectRepeatedDays)
                }
                
                AddAlarmDurationSection(duration: $duration, isTabbed: $isTabbed, selectedDuration: selectedDuration)
                
                AddAlarmMissionBanner(someToggle: $someToggle)
                
                if title == "Add" {
                    Button(action: {
                        createAlarm()
                    }) {
                        ButtonContent(buttonContent: "Save")
                    }
                    .disabled(repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? false : true)
                    
                } else {
                    if let alarms = alarmVM.alarms?.sorted(by:{$0.postedDate < $1.postedDate}) {
                        ForEach(alarms.indices, id:\.self) { i in
                            let alarm = alarms[i]
                            
                            if (alarm.postedDate == selectedPostDate) {
                                
                                Button(action: {
                                    alarmVM.editAlarm(old: alarm, newAlarmTime: alarmTimeSettings.selectedTime, newRawAlarmTime: alarmTimeSettings.rawAlarmTime, newMission: mission, newRepeatDays: repeatDaysSettings.selectedDays, newDuration: duration, newPostedDate: selectedPostDate)

                                    afterButtonActionFunc()
                                }) {
                                    ButtonContent(buttonContent: "Update")
                                }
                                .disabled(repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? false : true)
                            }
                        }
                    }
                }
            }
        }
        .environmentObject(repeatDaysSettings)
        .environmentObject(alarmTimeSettings)
    }
    
    func afterButtonActionFunc() {
        self.presentationMode.wrappedValue.dismiss()
        NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
    }
    
    func createAlarm() {
        let alarm = Alarm()
        alarm.alarmTime = alarmTimeSettings.selectedTime
        alarm.rawAlarmTime = alarmTimeSettings.rawAlarmTime
        for i in repeatDaysSettings.selectedDays {
            alarm.repeatDays.append(String(i))
        }
        alarm.duration = duration
        alarm.mission = mission
        alarm.toggle = true
        
        alarmVM.addAlarm(alarm: alarm)
        afterButtonActionFunc()
    }
    
    func ButtonContent(buttonContent:String) -> some View {
        ZStack(alignment: .center) {
            createContentBlock(title: "", height: 56, RecColor: repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? "4FCCBC" : "B7CAC8")
                .animation(.easeInOut(duration: 0.3), value: repeatDaysSettings.selectedDays.isEmpty != true && duration != 0)
            Text(buttonContent)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(hex: "ffffff")).padding(.top, 10)
        }
    }
    
}

