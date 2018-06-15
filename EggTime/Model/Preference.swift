//
//  Preference.swift
//  EggTime
//
//  Created by 曾艺伦 on 2018/6/14.
//  Copyright © 2018年 曾艺伦. All rights reserved.
//

import Cocoa

struct Preferences {
    
    var custom: Bool {
        get {
            let custom = UserDefaults.standard.bool(forKey: "custom")
            return custom
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "custom")
        }
    }
    
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            return 60 * 6 * 1000
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
    
}
