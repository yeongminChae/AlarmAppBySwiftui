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
    @EnvironmentObject var repeatDaysSettings: RepeatDaysSettings
    
    @State private var isTabbed: [Bool] = Array(repeating: false, count: 7)
    @State var selectRepeatedDays: [String]
    @State var commonElements: [String] = []
    
    let daysOfWeek: [String] = ["S","M","T","W","T","F","S"]
    let daysOfWeekFull: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer().frame(height: 25)
            
            HStack {
                ForEach(0..<daysOfWeek.count, id: \.self) { i in
                    AddAlarmRepeatBannerText(day: daysOfWeek[i], isOnTabbed: $isTabbed[i])
                        .onTapGesture {
                            isTabbed[i].toggle()
                        }
                        .onChange(of: isTabbed[i]) { newValue in
                            if isTabbed[i] {
                                repeatDaysSettings.selectedDays.append(daysOfWeekFull[i])
                            } else {
                                repeatDaysSettings.selectedDays.removeAll { day in
                                    day == daysOfWeekFull[i]
                                }
                            }
                        }
                        .onAppear {
                            let day = daysOfWeekFull[i]
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1 ) {
                                isTabbed[i] = commonElements.contains(day)
                            }
                        }
                }
            }
        }
        .frame(maxHeight: 76)
        .onAppear {
            commonElements = daysOfWeekFull.filter { selectRepeatedDays.contains($0) }
        }
        .onChange(of: selectRepeatedDays) { newValue in
            commonElements = daysOfWeekFull.filter { newValue.contains($0) }
        }
        
    }
}

