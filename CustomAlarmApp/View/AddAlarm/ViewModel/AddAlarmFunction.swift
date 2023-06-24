//
//  AddAlarmFunction.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/17.
//

import Foundation
import SwiftUI

func durationIndex(for duration: Int) -> Int {
    switch duration {
    case 5 :
        return 0
    case 15 :
        return 1
    case 30 :
        return 2
    default :
        return 0
    }
}

func durationClick(duration:Int, isOnTabbed: Binding<Bool>) -> some View {
    HStack {
        Text("\(duration) mins").padding(.leading, 5)
        Spacer()
        Image(systemName: isOnTabbed.wrappedValue ? "checkmark" : "")
            .foregroundColor(Color(hex: "04B69F")).padding(.trailing, 8)
    }
    .padding(.horizontal, 15)
    .frame(maxHeight: 156 / 3)
    .animation(.easeOut(duration: 0.3))
}

func createContentBlock(title:String, height:CGFloat, RecColor:String) -> some View {
    VStack(alignment: .leading) {
        Text(title)
            .padding(.leading)
            .font(.system(size: 13, weight: .regular)).foregroundColor(Color(hex: "666666"))
        RoundedRectangle(cornerRadius: 36)
            .frame(width: 358, height: height).foregroundColor(Color(hex:RecColor))
    }
}

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter.string(from: date)
}

func AddAlarmRepeatBannerText(day:String, isOnTabbed: Binding<Bool>) -> some View {
    Text(day)
        .id(day)
        .frame(width: 35, height: 35)
        .font(.system(size: 17, weight: .semibold))
        .animation(.spring(blendDuration: 3))
        .foregroundColor(Color(hex: !isOnTabbed.wrappedValue ? "B5EBE4" : "ffffff"))
        .background(Color(hex: isOnTabbed.wrappedValue ? "4FCCBC" : "ffffff"))
        .clipShape(Circle())
        .overlay(
            Circle().stroke(
                Color(hex: !isOnTabbed.wrappedValue ? "B5EBE4" : "4FCCBC"), lineWidth: 2.5
            ).animation(.spring(blendDuration: 3))
        )
}

func createButtonContent(buttonContent: String, repeatDaysSettings: RepeatDaysSettings, duration: Int) -> some View {
    
    ZStack(alignment: .center) {
        createContentBlock(title: "", height: 56, RecColor: repeatDaysSettings.selectedDays.isEmpty && duration != 0 ? "4FCCBC" : "B7CAC8")
            .animation(.easeInOut(duration: 0.3), value: repeatDaysSettings.selectedDays.isEmpty && duration != 0)
        Text(buttonContent)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(Color(hex: "ffffff"))
            .padding(.top, 10)
    }
}

//func RepeatBanner(selectRepeatedDays:[String]) -> some View {
//    ZStack {
//        createContentBlock(title: "REPEAT", height: 76, RecColor: "ffffff")
//        AddAlarmRepeatBanner(selectRepeatedDays: selectRepeatedDays)
//    }
//}
//
