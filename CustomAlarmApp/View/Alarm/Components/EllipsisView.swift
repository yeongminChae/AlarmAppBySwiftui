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
            Menu {
                Button(role: .destructive ,action: {
                    self.presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1 ) {
                        alarmVM.deleteAlarm(alarm: proData)
                        NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
                    }
                }) {
                    Text("Delete")
                }
                Button(action: {
                    self.isClicked.toggle()
                    selectRepeatedDays.removeAll()
                    for i in proData.repeatDays {
                        selectRepeatedDays.append(i)
                    }
                }) {
                    Text("Edit")
                }
                
            } label: {
                Label("", systemImage: "ellipsis").foregroundColor(.black)
            }
            .sheet(isPresented: $isClicked) {
                AddAlarm(alarmVM: AlarmViewModel(), selectedPostDate: proData.postedDate,
                         selectedAlarmTime: proData.alarmTime, selectedDuration: proData.duration, selectRepeatedDays: $selectRepeatedDays, title: "Edit" )
            }
        }
    }
}
