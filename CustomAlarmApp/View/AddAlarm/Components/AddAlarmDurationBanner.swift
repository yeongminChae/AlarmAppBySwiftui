//
//  AddAlarmDurationBanner.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/17.
//

import SwiftUI

struct AddAlarmDurationBanner: View {
    @State private var isTabbed: [Bool] = Array(repeating: false, count: 3)
    @State private var duration = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            ForEach([5, 15, 30] , id: \.self) { i in
                durationClick(duration: i, isOnTabbed: $isTabbed[i == 5 ? 0 : i == 15 ? 1 : 2])
                    .background(
                        Rectangle()
                            .opacity(0.0000000001)
                            .onTapGesture {
                                if i == 5 {
                                    isTabbed[0] = true
                                    isTabbed[1] = false
                                    isTabbed[2] = false
                                } else if i == 15 {
                                    isTabbed[0] = false
                                    isTabbed[1] = true
                                    isTabbed[2] = false
                                } else {
                                    isTabbed[0] = false
                                    isTabbed[1] = false
                                    isTabbed[2] = true
                                }
                                duration = i
                            }
                    )
                Divider().padding(.leading, 18)
            }
        }
    }
}

struct AddAlarmDurationBanner_Previews: PreviewProvider {
    static var previews: some View {
        AddAlarmDurationBanner()
    }
}
