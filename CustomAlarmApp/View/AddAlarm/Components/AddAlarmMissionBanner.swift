//
//  AddAlarmMissionBanner.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/24.
//

import SwiftUI

struct AddAlarmMissionBanner: View {
    @Binding var someToggle: Bool
    
    var body: some View {
        createContentBlock(title: "", height: 56, RecColor: "ffffff")
            .overlay(
                HStack {
                    Text("Mission").padding(.leading, 5)
                    Spacer()
                    
                    Toggle("", isOn: $someToggle).toggleStyle(ToggleStyleCustom())
                }
                .padding(.horizontal, 15)
                .padding(.top, 10)
            )
    }
}
