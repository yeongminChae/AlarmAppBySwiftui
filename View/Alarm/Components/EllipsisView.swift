//
//  EllipsisView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/21.
//

import SwiftUI

class SelectedPostDate: ObservableObject {
    @Published var selectedPostDate:Date = Date()
}

struct EllipsisView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var selectedPostDate: SelectedPostDate
    @ObservedObject var alarmVM: AlarmViewModel
    @State private var isClicked: Bool = false
    
    var proData: Alarm
    
    init(_ proData: Alarm, alarmVM: AlarmViewModel) {
        self.alarmVM = alarmVM
        self.proData = proData
    }
    
    var body: some View {
        ZStack {
            let _ = print("elipsisview \(selectedPostDate.selectedPostDate)")
            
            RoundedRectangle(cornerRadius: 15).frame(width: 75, height: 50).foregroundColor(.teal)
                .overlay(
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1 ) {
                                alarmVM.deleteAlarm(alarm: proData)
                                NotificationCenter.default.post(name: NSNotification.Name("RefreshAlarmView"), object: nil)
                            }
                        }){
                            Text("Delete").foregroundColor(.red)
                        }
                        
                        Button(action: {
                            selectedPostDate.selectedPostDate = proData.postedDate
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5 ) {
                                self.isClicked.toggle()
                            }
                            let _ = print("proData \(selectedPostDate.selectedPostDate)")
                        }){
                            Text("Edit").foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isClicked) {
                            AddAlarm(alarmVM: AlarmViewModel(), title: "Edit")
                        }
                    }
                    
                )
        }
    }
}
