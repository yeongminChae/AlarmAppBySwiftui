//
//  CustomAlarmAppApp.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI

@main
struct CustomAlarmAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(alarmVM: AlarmViewModel())
        }
    }
}
