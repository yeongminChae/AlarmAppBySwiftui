//
//  AlarmView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @StateObject private var selectedPostDate = SelectedPostDate()
    
    @State var isToggled: [Bool]
    @State var onDelEditBtn: Bool = false
    
    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
        let alarmCount = alarmVM.alarms?.count
        _isToggled = State(initialValue: alarmVM.alarms?.map({ $0.toggle }) ?? [])
    }
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color(hex: "F2F2F2")).ignoresSafeArea()
            TitleHeader(title: "Alarm", isHidden: false)
            
            VStack(alignment: .center, spacing: 15) {
                
                RoundedRectangle(cornerRadius: 28).frame(width: 358, height: 68).foregroundColor(Color(.white)).opacity(0)
//                if let alarms = alarmVM.alarms?.sorted(by:{$0.alarmTime.components(separatedBy: " ")[0] == "오전" ? $0.alarmTime < $1.alarmTime : $0.alarmTime > $1.alarmTime}) {
                if let alarms = alarmVM.alarms?.sorted(by:{$0.alarmTime < $1.alarmTime}) {
                    
                    ScrollView() {
                        VStack(alignment: .center, spacing: 10) {
                            
                            ForEach(alarms.indices, id: \.self) { i in
                                let alarm = alarms[i]
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 28).frame(width: 358, height: 112).foregroundColor(!isToggled[i] ? Color(hex: "D8E9E7") : Color(.white))
                                    VStack {
                                        HStack {
                                            RoundedRectangle(cornerRadius: 9).frame(width: 52, height: 21).foregroundColor(!isToggled[i] ? Color(hex: "B7CAC8") : Color(hex: "4FCCBC"))
                                                .overlay(
                                                    AlarmViewTextFormat(contents:"\(String(alarm.duration))mins", fontSize: 11, fontWeight: .semibold)
                                                        .foregroundColor(.white)
                                                )
                                            RoundedRectangle(cornerRadius: 9).frame(width: 91, height: 21).foregroundColor(!isToggled[i] ? Color(hex: "F2F8F7") : Color(hex: "D4F5F1"))
                                                .overlay(
                                                    AlarmViewTextFormat(contents: alarm.repeatDays.joined(separator: ", "), fontSize: 11, fontWeight: .semibold)
                                                        .foregroundColor(!isToggled[i] ? Color(hex: "B7CAC8") : Color(hex: "04B69F"))
                                                )
                                            Spacer()
                                            
                                            ZStack {
                                                Image(systemName: "ellipsis")
                                                    .onTapGesture {
                                                        onDelEditBtn.toggle()
                                                    }
                                                if onDelEditBtn {
                                                    EllipsisView(alarm, alarmVM: AlarmViewModel())
                                                }
                                                Spacer()
                                            }.environmentObject(selectedPostDate)

                                        }.padding(.horizontal, 35).padding(.top, 5)

                                        HStack(alignment: .lastTextBaseline) {
                                            AlarmViewTextFormat(contents: alarm.alarmTime.components(separatedBy: " ")[1], fontSize: 42, fontWeight: .medium)
                                                .foregroundColor(!isToggled[i] ? Color(hex: "99ABA9") : .black)
                                            AlarmViewTextFormat(contents: alarm.alarmTime.components(separatedBy: " ")[0], fontSize: 28, fontWeight: .semibold)
                                                .foregroundColor(!isToggled[i] ? Color(hex: "B7CAC8") : Color(hex: "4FCCBC"))
                                            Spacer()
                                        }.padding(.horizontal, 35)

                                    }

                                    Toggle("", isOn: $isToggled[i]).toggleStyle(ToggleStyleCustom()).padding(.horizontal, 35).padding(.top, 50)
                                        .onChange(of: isToggled[i]) { newValue in
                                            alarmVM.editToggle(old: alarm, newToggleValue: newValue)
                                        }
                                }
                                .onTapGesture {
                                    onDelEditBtn.toggle()
                                }
                            }
                        }
                    }
                    .padding(.top, -17)
                    .refreshable {
                        alarmVM.refreshAlarms()
                    }
                }
                if alarmVM.alarms?.isEmpty == true {
                    VStack {
                        Text("No Alarms yet.")
                        Spacer()
                    }.frame(maxHeight: .infinity)

                }
                
                Divider()
            }
            
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RefreshAlarmView"))) { _ in
            self.alarmVM.alarms = self.alarmVM.realm.objects(Alarm.self)
            let alarmCount = self.alarmVM.alarms?.count
            self.isToggled = alarmVM.alarms?.map({ $0.toggle }) ?? []
        }
    }
}
