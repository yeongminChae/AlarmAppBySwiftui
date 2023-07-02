//
//  AddAlarmData.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import Foundation
import RealmSwift

class Alarm: Object {
    @Persisted var alarmTime: String
    @Persisted var rawAlarmTime: String
    @Persisted var mission: Bool
    @Persisted var toggle: Bool
    @Persisted var repeatDays = List<String>()
    @Persisted var duration: Int
    @Persisted var postedDate: Date = Date.now
    
    var repeatDaysArray: [String] {
        get {
            repeatDays.map { $0 }
        }
        set {
            repeatDays.removeAll()
            repeatDays.append(objectsIn: newValue)
        }
    }
}
