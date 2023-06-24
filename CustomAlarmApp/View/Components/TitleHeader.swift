//
//  TitleHeader.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI

struct TitleHeader: View {
    @State var title: String
    @State var isHidden: Bool
    @State private var isClicked: Bool = false
    @State private var newArr: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                    .padding()
                
                Spacer()
                Button(action: {
                    self.isClicked.toggle()
                }){
                    Image(systemName: isHidden ? "" : "plus").font(.system(size: 28, weight: .medium)).foregroundColor(Color(hex: "04B69F"))
                }
                .padding()
            }
            .sheet(isPresented: $isClicked) {
                AddAlarm(alarmVM: AlarmViewModel(), selectedPostDate: Date(), selectedAlarmTime: "", selectedDuration:0 , selectRepeatedDays: $newArr, title: "Add")
            }
            Spacer()
        }.padding(.horizontal, 10)
    }
}
