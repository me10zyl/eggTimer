//
//  ViewController.swift
//  EggTime
//
//  Created by 曾艺伦 on 2018/6/12.
//  Copyright © 2018年 曾艺伦. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var countDownLabel: NSTextField!
    @IBOutlet weak var imgView: NSImageView!
    @IBAction func startBtnClicked(_ sender: Any) {
    }
    @IBAction func endBtnClicked(_ sender: Any) {
    }
    @IBAction func resetBtnClicked(_ sender: Any) {
    }
    
    @IBAction func startTimerMenuItemSelected(_ sender: Any) {
        endBtnClicked(sender)
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
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

