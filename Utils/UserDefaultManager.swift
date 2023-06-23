//
//  UserDefaultManager.swift
//  CustomAlarmApp
//
//  Created by 채영민 on 2023/06/18.
//

import Foundation
import UIKit

enum UserDefaultKey: String {
    case feel
    case toggle
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}

    var toggle: String? {
        get{
            guard let toggle = UserDefaults.standard.value(forKey: UserDefaultKey.toggle.rawValue) as? String else { return nil }
            return toggle
        }
        
        set(toggle){
            UserDefaults.standard.set(toggle, forKey: UserDefaultKey.toggle.rawValue)
        }
    }
    
    var feel: String? {
        get{
            guard let feel = UserDefaults.standard.value(forKey: UserDefaultKey.feel.rawValue) as? String else { return nil }
            return feel
        }
        
        set(feel){
            UserDefaults.standard.set(feel, forKey: UserDefaultKey.feel.rawValue)
        }
    }

    
}
