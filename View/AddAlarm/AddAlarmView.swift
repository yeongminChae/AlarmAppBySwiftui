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
    @StateObject private var selectedPostDate = SelectedPostDate()
    
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
            
            let _ = print("addalarm \(selectedPostDate.selectedPostDate)")
            
            VStack(spacing: 20) {
                AddAlarmHeader(title: title)
                Spacer()
                
                AddAlarmDatePicker().frame(height: 130)
                Spacer()
                
                ZStack {
                    createContentBlock(title: "REPEAT", height: 76, RecColor: "ffffff")
                    AddAlarmRepeatBanner()
                }
                
                createContentBlock(title: "DURATION", height: 156, RecColor: "ffffff")
                    .overlay(
                        VStack(alignment: .center, spacing: 0) {
                            Spacer()
                            ForEach([5, 15, 30], id: \.self) { i in
                                durationClick(duration: i, isOnTabbed: $isTabbed[durationIndex(for: i)])
                                    .background(
                                        Rectangle().opacity(0.0000000001)
                                            .onTapGesture {
                                                selectDuration(i)
                                            }
                                    )
                                Divider().padding(.leading, 18)
                            }
                        }
                    )
                
                createContentBlock(title: "", height: 56, RecColor: "ffffff")
                    .overlay (
                        HStack {
                            Text("Mission").padding(.leading, 5)
                            Spacer()
                            
                            Toggle("", isOn: $someToggle).toggleStyle(ToggleStyleCustom())
                        }
                            .padding(.horizontal, 15).padding(.top, 10)
                    )
                
                if title == "Add" {
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
                } else {
                    Button(action: {
                        let newAlarm = Alarm()
                        newAlarm.alarmTime = alarmTimeSettings.selectedTime
                        for i in repeatDaysSettings.selectedDays {
                            newAlarm.repeatDays.append(String(i))
                        }
                        newAlarm.duration = duration
                        newAlarm.mission = mission
                        newAlarm.toggle = true
                        
                        let _ = print("newAlarm \(newAlarm)")
                        let _ = print("Alarmvm() \(alarmVM.alarms?.indices)")
                        //                        alarmVM.addAlarm(alarm: alarm)
                        //                        alarmVM.editAlarm(old: , newAlarmTime: newAlarm.alarmTime, newMission: newAlarm.mission, newRepeatDays: newAlarm.repeatDays, newDuration: newAlarm.duration, newPostedDate: newAlarm.postedDate)
                        self.presentationMode.wrappedValue.dismiss()
                        
                        NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
                    }) {
                        ZStack(alignment: .center) {
                            createContentBlock(title: "", height: 56, RecColor: repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? "4FCCBC" : "B7CAC8")
                                .animation(.easeInOut(duration: 0.3), value: repeatDaysSettings.selectedDays.isEmpty != true && duration != 0)
                            Text("Update")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color(hex: "ffffff")).padding(.top, 10)
                        }
                    }
                    .disabled(repeatDaysSettings.selectedDays.isEmpty != true && duration != 0 ? false : true)
                }
                
            }
        }
        .environmentObject(selectedPostDate)
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
