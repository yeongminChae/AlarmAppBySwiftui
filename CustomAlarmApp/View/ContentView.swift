//
//  ContentView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/15.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @ObservedObject var alarmVM: AlarmViewModel
    
    var body: some View {
        ZStack {
            VStack {
                let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let _ = print(documentsDirectory)
                
                TabView {
                    UpcomingView(alarmVM: AlarmViewModel())
                        .tabItem {
                            Image(systemName: "sparkles")
                            Text("Upcoming")
                        }

                    AlarmView(alarmVM: AlarmViewModel())
                        .tabItem {
                            Image(systemName: "alarm.fill")
                            Text("Alarm")
                        }

                }
                .accentColor(Color(hex: "04B69F"))
            }
        }
    }
}
