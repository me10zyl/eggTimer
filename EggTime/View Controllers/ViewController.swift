//
//  ViewController.swift
//  EggTime
//
//  Created by 曾艺伦 on 2018/6/12.
//  Copyright © 2018年 曾艺伦. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    func stringFromTimeInterval(interval: Double) -> String {
        let ti = NSInteger(interval / 1000)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        return String(format: "%0.1d:%0.2d",minutes,seconds)
    }
    
    
    struct timeupdater:TimerUpdate{
        var controller: ViewController
        func updateTime(totalTime: Double) {
            controller.fireUIChanged(totalTime: totalTime)
            if totalTime == 0 {
                controller.startBtn.isEnabled = false
                controller.resetBtn.isEnabled = true
                controller.endBtn.isEnabled = false
                controller.updateMenu()
            }
        }
    }
    
    var timeUpdater:TimerUpdate!

    @IBOutlet weak var startBtn: NSButton!
    @IBOutlet weak var endBtn: NSButton!
    @IBOutlet weak var resetBtn: NSButton!
    @IBOutlet weak var countDownLabel: NSTextField!
    var eggTimer : EggTimer!;
    @IBOutlet weak var imgView: NSImageView!
    
    
    @IBAction func startBtnClicked(_ sender: Any) {
        eggTimer.start()
        startBtn.isEnabled = false
        resetBtn.isEnabled = false
        endBtn.isEnabled = true
        updateMenu();
    }
    @IBAction func endBtnClicked(_ sender: Any) {
        eggTimer.end()
        endBtn.isEnabled = false
        startBtn.isEnabled = true
        resetBtn.isEnabled = true
        updateMenu();
        fireUIChanged(totalTime: eggTimer.totalTime)
    }
    @IBAction func resetBtnClicked(_ sender: Any) {
        eggTimer.reset()
       fireUIChanged(totalTime: EggTimer.prefTime)
        resetBtn.isEnabled = false
        endBtn.isEnabled = false
        startBtn.isEnabled = true
        updateMenu();
    }
    
    func updateMenu(){
        if let appDel = NSApplication.shared.delegate as? AppDelegate {
            appDel.enableMenus(start: startBtn.isEnabled, stop: endBtn.isEnabled, reset: resetBtn.isEnabled)
        }
    }
    
    @IBAction func startTimerMenuItemSelected(_ sender: Any) {
        startBtnClicked(sender)
    }
    
    @IBAction func stopTimerMenuItemSelected(_ sender: Any) {
        endBtnClicked(sender)
    }
    
    @IBAction func resetTimerMenuItemSelected(_ sender: Any) {
        resetBtnClicked(sender)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         self.timeUpdater = timeupdater(controller: self)
         eggTimer = EggTimer(timerUpdate: self.timeUpdater)
        self.setupPrefs()
        endBtn.isEnabled = false
        resetBtn.isEnabled = false
       fireUIChanged(totalTime: EggTimer.prefTime)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController {
    func fireUIChanged(totalTime: Double){
        self.countDownLabel.stringValue = textToDisplay(totalTime: totalTime)
        self.imgView.image = imgToDisplay(totalTime: totalTime)
    }
    
    func textToDisplay(totalTime: Double) -> String{
         return self.stringFromTimeInterval(interval: totalTime)
    }
    
    func imgToDisplay(totalTime: Double) -> NSImage{
        let percentageComplete = 100 - eggTimer.totalTime / EggTimer.prefTime * 100
        let imageName: String
        if eggTimer.isStopped() {
            imageName = "stopped"
            return NSImage(named: NSImage.Name(rawValue: imageName))!
        }
        switch percentageComplete {
        case 0 ..< 25:
            imageName = "0"
        case 25 ..< 50:
            imageName = "25"
        case 50 ..< 75:
            imageName = "50"
        case 75 ..< 100:
            imageName = "75"
        default:
            imageName = "100"
        }
        
        return NSImage(named: NSImage.Name(rawValue: imageName))!
    }

}


extension ViewController {
    
    // MARK: - Preferences
    
    func setupPrefs() {
    
        let notificationName = Notification.Name(rawValue: "PrefsChanged")
        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: nil, queue: nil) {
                                                (notification) in
                                                self.resetBtnClicked(self)
        }
    }
   
    
}
