//
//  AlarmViewModel.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/16.
//

import RealmSwift

class AlarmViewModel: ObservableObject {
    @Published var alarms: Results<Alarm>?
    var realm: Realm
    
    init() {
        do {
            realm = try Realm()
            alarms = realm.objects(Alarm.self)
        } catch {
            // Handle error
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func addAlarm(alarm: Alarm) {
        do {
            try realm.write {
                realm.add(alarm)
            }
            alarms = realm.objects(Alarm.self)
        } catch {
            // Handle error
            print("Failed to add alarm: \(error.localizedDescription)")
        }
    }
    
    func deleteAlarm(alarm: Alarm) {
        do {
            try realm.write {

                realm.delete(alarm)
            }
        } catch {
            // Handle error
            print("Failed to delete alarm: \(error.localizedDescription)")
        }
    }
    
    func refreshAlarms() {
           alarms = realm.objects(Alarm.self)
       }
    
//    func editAlarm(old: Alarm, newAlarmTime:String, newMission: Bool, newRepeatDays: List<String>, newDuration : Int, newPostedDate: Date) {
    func editAlarm(old: Alarm, newAlarmTime:String, newMission: Bool, newRepeatDays: [String], newDuration : Int, newPostedDate: Date) {
        do {
            let realm = try Realm()
            
            try realm.write {
                old.alarmTime = newAlarmTime
                old.mission = newMission
//                old.repeatDays = newRepeatDays
                old.repeatDaysArray = newRepeatDays
                old.duration = newDuration
                old.postedDate = newPostedDate
            }
        } catch {
            // Handle error
            print("Failed to edit alarm: \(error.localizedDescription)")
        }
    }
    
    func editToggle(old: Alarm, newToggleValue: Bool) {
        do {
            let realm = try Realm()
            
            try realm.write {
                old.toggle = newToggleValue
            }
        } catch {
            // Handle error
            print("Failed to edit alarm: \(error.localizedDescription)")
        }
    }
}
