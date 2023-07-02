//
//  UpcomingView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @StateObject private var upcomingAlarmSettings = UpcomingAlarmSettings()
    @State var isToggled:[Bool]
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    
    let now = Date()
    var weekday: String {
        return now.formatted(as: "EEEE")
    }
    
    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
        let alarmCount = alarmVM.alarms?.count
        _isToggled = State(initialValue: Array(repeating: true, count: alarmCount ?? 0))
    }
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color(hex: "F2F2F2")).ignoresSafeArea()
            TitleHeader(title: "Upcoming", isHidden: true)

                VStack(alignment: .center, spacing: 15) {
                    Spacer()
                    
                    ZStack {
                        Image("UpcomingBox")
                            .overlay(
                                VStack{
                                    UpcomingTopPart(alarmVM: AlarmViewModel())
                                    Rectangle().opacity(0)
                                    Spacer()
                                    UpcomingDownPart(alarmVM: AlarmViewModel())
                                        .environmentObject(upcomingAlarmSettings)
                                }
                            )
                    }
                    
                    Button(action: {
                        
                    }) {
                        RoundedRectangle(cornerRadius: 36).frame(width: 358, height: 56).foregroundColor(Color(hex: "B7CAC8"))
                            .overlay(
                                HStack {
                                    Image(systemName: "bell.fill")
                                    AlarmViewTextFormat(contents: formattedRemainingTime(), fontSize: 18, fontWeight: .semibold)
                                }.foregroundColor(.white)
                            )
                    }
                    
                    Divider()
                }
                .onAppear {
                    if let alarms = alarmVM.alarms, !alarms.isEmpty {
                        startTimer()
                    } else {
                        remainingTime = 0
                    }
                }
                .onDisappear {
                    stopTimer()
                }
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RefreshAlarmView"))) { _ in
                    calculateRemainingTime()
                }
        }
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            calculateRemainingTime()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func calculateRemainingTime() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1 ) {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.timeZone = TimeZone.current
            
            let currentTime = formatter.string(from: date)
            let currentTime2 = formatter.date(from: currentTime)
            let upcoming = formatter.date(from: upcomingAlarmSettings.upcomingAlarm)
            let timeCalculater: TimeInterval
            
            if upcomingAlarmSettings.upcomingAmPm == "AM" {
                timeCalculater =  (currentTime2 ?? Date()) - (upcoming ?? Date())
            } else if upcomingAlarmSettings.upcomingAmPm == "" {
                timeCalculater = 0
            } else {
                timeCalculater = (upcoming ?? Date()) - (currentTime2 ?? Date())
            }
            remainingTime = timeCalculater
        }
    }
    
    func formattedRemainingTime() -> String {
        let hours = abs(Int(remainingTime / 3600))
        let minutes = abs(Int(remainingTime / 60) % 60)
        let seconds = abs(Int(remainingTime) % 60)
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
