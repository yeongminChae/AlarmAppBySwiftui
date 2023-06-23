//
//  AddAlarmViewModel.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import Foundation

func durationClick(duration:Int, isOnTabbed: Binding<Bool>) -> some View {
    HStack {
        Text("\(duration) mins").padding(.leading, 5)
        Spacer()
        Image(systemName: isOnTabbed.wrappedValue ? "checkmark" : "")
            .foregroundColor(Color(hex: "04B69F")).padding(.trailing, 8)
    }
    .padding(.horizontal, 15)
    .frame(maxHeight: 156 / 3)
    .animation(.easeOut(duration: 0.15))
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
