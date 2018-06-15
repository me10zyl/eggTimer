//
//  PrefsViewController.swift
//  EggTime
//
//  Created by 曾艺伦 on 2018/6/12.
//  Copyright © 2018年 曾艺伦. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {
    
    @IBOutlet weak var popUpMenu: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var okBtn: NSButton!
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var minutesLabel: NSTextField!
    var eggTimer: EggTimer = EggTimer()
    var viewController: ViewController!
    var selectTime: Double!
    var preference = Preferences()
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.view.window?.close()
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        selectTime = getPrefValue()
        fireUIChanged()
    }
    
    
    @IBAction func popUpBtnChanged(_ sender: Any) {
        selectTime = getPrefValue()
        fireUIChanged()
    }
    
    
    
    func fireUIChanged(){
        if(isSelectTag()){
            customSlider.isEnabled = true
        }else{
            customSlider.isEnabled = false
        }
        minutesLabel.stringValue = String(format:"%.0f分钟",selectTime / 60 / 1000)
        
    }
    
    func isSelectTag()->Bool{
        return popUpMenu.selectedItem?.tag == 0
    }
    
    
    @IBAction func okBtnClicked(_ sender: Any) {
        selectTime = getPrefValue()
        if(isSelectTag()){
            preference.custom = true
        }else{
            preference.custom = false
        }
        EggTimer.prefTime = selectTime
        preference.selectedTime = selectTime
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PrefsChanged"),
                                        object: nil)
        self.view.window?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "viewController")) as! ViewController
        selectTime = EggTimer.prefTime
        if preference.custom {
            slider.integerValue = Int(selectTime / 60 / 1000)
            popUpMenu.selectItem(withTag: 0)
        } else {
            popUpMenu.selectItem(withTag: Int(selectTime / 60 / 1000))
        }
        fireUIChanged()
    }
    
}

extension PrefsViewController{
    func getPrefValue()->Double{
        let tag = popUpMenu.selectedItem?.tag
        if(tag != 0){
            return Double(tag!) * 60 * 1000
        }
        return slider.doubleValue * 60 * 1000
    }

}

