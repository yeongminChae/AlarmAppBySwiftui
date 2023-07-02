//
//  SwiftUIView.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/26.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack {
            Menu {
                Button("Search", action: {})
                Button("Add", action: {})
            } label: {
                Label("", systemImage: "ellipsis").foregroundColor(.black)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
