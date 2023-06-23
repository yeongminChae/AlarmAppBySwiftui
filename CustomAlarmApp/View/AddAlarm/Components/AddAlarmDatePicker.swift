//
//  AddAlarmDatePicker.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import SwiftUI

class AlarmTimeSettings: ObservableObject {
    @Published var selectedTime: String = ""
}

struct AddAlarmDatePicker: View {
    @State private var alarmPicker = Date()
    @EnvironmentObject var alarmTimeSettings: AlarmTimeSettings
    
    var body: some View {
        VStack {
            DatePicker("",selection: $alarmPicker,
                       displayedComponents: .hourAndMinute )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .onAppear {
                handleFormattedDate(Date())
            }
            .onChange(of: alarmPicker) { newValue in
                handleFormattedDate(newValue)
            }
        }
    }
    
    func handleFormattedDate(_ date:Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.timeZone = TimeZone.current
        
        let formatterdDate = formatter.string(from: date)
        let defaultDate = formatter.string(from: Date())
        
        alarmTimeSettings.selectedTime = formatterdDate
        
    }
}