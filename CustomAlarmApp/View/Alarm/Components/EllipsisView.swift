//
//  EllipsisView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/21.
//

import SwiftUI

struct EllipsisView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var alarmVM: AlarmViewModel
    @State private var isClicked: Bool = false
    @State var selectRepeatedDays: [String] = []
    
    var proData: Alarm
    
    init(_ proData: Alarm, alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
        self.proData = proData
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15).frame(width: 75, height: 50).foregroundColor(.teal)
                .overlay(
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1 ) {
                                alarmVM.deleteAlarm(alarm: proData)
                                NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
                            }
                        }) {
                            Text("Delete").foregroundColor(.red)
                        }
                        
                        Button(action: {
                            self.isClicked.toggle()
                            selectRepeatedDays.removeAll()
                            for i in proData.repeatDays {
                                selectRepeatedDays.append(i)
                            }
                        }) {
                            Text("Edit").foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isClicked) {
                            AddAlarm(alarmVM: AlarmViewModel(), selectedPostDate: proData.postedDate,
                                     selectedAlarmTime: proData.alarmTime, selectedDuration: proData.duration, selectRepeatedDays: $selectRepeatedDays, title: "Edit" )
                        }
                    }
                    
                )
        }
    }
}
