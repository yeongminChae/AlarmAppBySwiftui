//
//  UpcomingView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var alarmVM: AlarmViewModel
    @State var isToggled:[Bool]
    
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
                            }
                        )
                }
                
                Button(action: {
                    
                }){
                    RoundedRectangle(cornerRadius: 36).frame(width: 358, height: 56).foregroundColor(Color(hex: "B7CAC8"))
                        .overlay(
                            HStack {
                                Image(systemName: "bell.fill")
                                AlarmViewTextFormat(contents: "00:00:00", fontSize: 18, fontWeight: .semibold)
                            }.foregroundColor(.white)
                        )
                }
                    
                Divider()
            }

        }
    }
}
