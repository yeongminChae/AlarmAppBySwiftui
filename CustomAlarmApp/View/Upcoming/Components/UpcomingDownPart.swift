//
//  UpcomingDownPart.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/18.
//

import SwiftUI

class UpcomingAlarmSettings: ObservableObject {
    @Published var upcomingAlarm: String = ""
    @Published var upcomingAmPm: String = ""
}

struct UpcomingDownPart: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @EnvironmentObject var upcomingAlarmSettings: UpcomingAlarmSettings
    
    @State var isToggled:Bool = true
    
    let now = Date()
    var weekday: String {
        return now.formatted(as: "EEEE")
    }
    
    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
    }
    
    var body: some View {
        let dateFormatter = DateFormatter()

        ZStack {
            if let alarms = alarmVM.alarms, !alarms.isEmpty {
                let now = Date()
                let timeFormatter = DateFormatter()
                let closestAlarm = alarms
                    .sorted(by: {
                        timeFormatter.dateFormat = "a h:mm"
                        timeFormatter.timeZone = TimeZone.current
                        let time1 = timeFormatter.date(from: $0.alarmTime)
                        let time2 = timeFormatter.date(from: $1.alarmTime)
                        return time1?.compare(time2 ?? Date()) == .orderedAscending
                    })
                    .first(where: { alarm in
                        alarm.repeatDaysArray.contains(where: { $0 == weekday.prefix(3) }) &&
                        alarm.alarmTime > timeFormatter.string(from: Date())
                    })
                
                if let firstAlarm = closestAlarm ?? alarms.first  {
                HStack(alignment: .lastTextBaseline) {
                    
                    VStack(alignment: .leading) {
                        AlarmViewTextFormat(contents: "until", fontSize: 18, fontWeight: .semibold).foregroundColor(Color(hex: "04B69F"))
                        AlarmViewTextFormat(contents: firstAlarm.alarmTime.components(separatedBy: " ")[1], fontSize: 42, fontWeight: .medium).foregroundColor(.black)
                    }
                    
                    AlarmViewTextFormat(contents: firstAlarm.alarmTime.components(separatedBy: " ")[0], fontSize: 28, fontWeight: .semibold).foregroundColor(Color(hex: "04B69F"))
                    
                    Spacer()
                    
                    Toggle("", isOn: $isToggled).toggleStyle(ToggleStyleCustom()).offset(y: -5)
                }
                .onAppear {
                    if let alarms = alarmVM.alarms, !alarms.isEmpty {
                        upcomingAlarmSettings.upcomingAlarm = firstAlarm.rawAlarmTime
                        upcomingAlarmSettings.upcomingAmPm = firstAlarm.alarmTime.components(separatedBy: " ")[0]
                    } else {
                        upcomingAlarmSettings.upcomingAlarm = ""
                        upcomingAlarmSettings.upcomingAmPm = ""
                    }
                    NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
                }
                .padding(.horizontal, 15).padding(.bottom, 10)
            }
                
            }
            else {
                ZStack {
                    Text("")                    
                }
                .onAppear() {
                    upcomingAlarmSettings.upcomingAlarm = ""
                    upcomingAlarmSettings.upcomingAmPm = ""
                }
            }
            
        }
        .onAppear{
            alarmVM.refreshAlarms()
        }
    }
}
