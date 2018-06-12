//
//  AppDelegate.swift
//  EggTime
//
//  Created by 曾艺伦 on 2018/6/12.
//  Copyright © 2018年 曾艺伦. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var startMenuItem: NSMenuItem!
    
    @IBOutlet weak var endMenuItem: NSMenuItem!
    
    @IBOutlet weak var resetMenuItem: NSMenuItem!
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

