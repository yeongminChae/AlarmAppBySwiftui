//
//  DatasView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/18.
//

import SwiftUI

func AlarmViewTextFormat(contents:String, fontSize:CGFloat, fontWeight:Font.Weight) -> some View {
    Text(contents).font(.system(size: fontSize, weight: fontWeight))
}
