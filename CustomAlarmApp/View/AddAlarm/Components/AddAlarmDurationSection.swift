//
//  AddAlarmDurationSection.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/24.
//

import SwiftUI

struct AddAlarmDurationSection: View {
    @Binding var duration: Int
    @Binding var isTabbed: [Bool]
    @State var selectedDuration: Int
    
    var body: some View {
        createContentBlock(title: "SNOOZE", height: 156, RecColor: "ffffff")
            .overlay(
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    ForEach([5, 15, 30], id: \.self) { i in
                        durationClick(duration: i, isOnTabbed: $isTabbed[durationIndex(for: i)])
                            .background(
                                Rectangle().opacity(0.0000000001)
                                    .onTapGesture {
                                        selectDuration(i)
                                    }
                                    .onAppear {
                                        if selectedDuration != 0 {
                                            selectDuration(selectedDuration)
                                        }
                                    }
                            )
                        
                        if i != 30 {
                            Divider().padding(.leading, 18)
                        }
                    }
                }
            )
    }
    
    func selectDuration(_ duration: Int) {
        for i in 0..<isTabbed.count {
            isTabbed[i] = (i == durationIndex(for: duration))
        }
        self.duration = duration
    }
}
