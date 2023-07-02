//
//  UpcomingViewPart2.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/07/02.
//

import SwiftUI

struct UpcomingViewPart2: View {
    @ObservedObject var alarmVM: AlarmViewModel
    
    init(alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
    }
    
    var body: some View {
        let dateFormatter = DateFormatter()
        
        ZStack {
            Rectangle().foregroundColor(Color(hex: "F2F2F2")).ignoresSafeArea()
            TitleHeader(title: "Alarm", isHidden: false)
            
            VStack(alignment: .center, spacing: 15) {
                
                RoundedRectangle(cornerRadius: 28).frame(width: 358, height: 68).foregroundColor(Color(.white)).opacity(0)
                if let alarms = alarmVM.alarms?.sorted(by: {
                    dateFormatter.dateFormat = "a h:mm"
                    let time1 = dateFormatter.date(from: $0.alarmTime)
                    let time2 = dateFormatter.date(from: $1.alarmTime)
                    
                    return time1?.compare(time2 ?? Date()) == .orderedAscending
                }) {
                    
                    ScrollView() {
                        VStack(alignment: .center, spacing: 10) {
                            
                            ForEach(alarms.indices, id: \.self) { i in
                                let alarm = alarms[i]
                            }
                        }
                    }
                }
            }
        }
    }
}
