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
    @EnvironmentObject var alarmTimeSettings: AlarmTimeSettings
    
    @State private var alarmPicker = Date()
    @State var selectedAlarmTime: String
    
    var body: some View {
        VStack {
            DatePicker("",selection: $alarmPicker,
                       displayedComponents: .hourAndMinute )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .onAppear {
                if selectedAlarmTime == "" {
                    handleFormattedDate(Date())
                } else {
                    setInitialDate()
                }
            }
            .onChange(of: alarmPicker) { newValue in
                handleFormattedDate(newValue)
            }
        }
    }
    
    func setInitialDate() {
          let formatter = DateFormatter()
          formatter.dateFormat = "a h:mm"
          formatter.timeZone = TimeZone.current
          
          if let initialDate = formatter.date(from: selectedAlarmTime) {
              alarmPicker = initialDate
          }
      }
    
    func handleFormattedDate(_ date:Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.timeZone = TimeZone.current
        
        let formatterdDate = formatter.string(from: date)
        alarmTimeSettings.selectedTime = formatterdDate
    }
}
