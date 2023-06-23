//
//  AddAlarmRepeatBanner.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import SwiftUI

class RepeatDaysSettings: ObservableObject {
    @Published var selectedDays: [String] = []
}

struct AddAlarmRepeatBanner: View {
    @State private var isTabbed: [Bool] = Array(repeating: false, count: 7)
    @EnvironmentObject var repeatDaysSettings: RepeatDaysSettings

    let daysOfWeek:[String] = ["S","M","T","W","T","F","S"]
    let daysOfWeekFull:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer().frame(height: 25)
            
            HStack {
                ForEach(0..<daysOfWeek.count, id: \.self) { i in
                    AddAlarmRepeatBannerText(day: daysOfWeek[i] , isOnTabbed: $isTabbed[i])
                        .onTapGesture {
                            isTabbed[i].toggle()
                        }
                        .onChange(of: isTabbed[i]) {newValue in
                            print()
                            if isTabbed[i] {
                                repeatDaysSettings.selectedDays.append(daysOfWeekFull[i])
                            } else {
                                repeatDaysSettings.selectedDays.removeAll { day in
                                    day == daysOfWeekFull[i]
                                }
                            }

                        }
                }
            }
        }.frame(maxHeight: 76)
    }
}
