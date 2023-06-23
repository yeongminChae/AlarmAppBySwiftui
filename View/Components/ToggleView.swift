//
//  ToggleView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/17.
//

import SwiftUI

struct ToggleView: View {
    @Binding var someToggle: Bool
//    @State private var someToggle = true
    
    var body: some View {
        Toggle("", isOn: $someToggle)
            .toggleStyle(ToggleStyleCustom())
    }
}

