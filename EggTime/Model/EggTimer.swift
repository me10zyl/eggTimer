//
//  EggTimer.swift
//  EggTime
//
//  Created by 曾艺伦 on 2018/6/12.
//  Copyright © 2018年 曾艺伦. All rights reserved.
//
import Cocoa

protocol TimerUpdate {
    func updateTime(totalTime:Double)
}


class EggTimer {
    static var prefTime: Double = 1000 * 60 * 6 //6分钟
    var totalTime: Double = prefTime
    var timer: Timer = Timer()
    var timerUpdate: TimerUpdate?
    var isStartTime: Bool = false
    init(timerUpdate: TimerUpdate? = nil) {
        self.timerUpdate = timerUpdate
        EggTimer.prefTime = Preferences().selectedTime
        totalTime = EggTimer.prefTime
    }
    
    func updatePrefTime(){
        totalTime = EggTimer.prefTime
    }
    
    func start(){
        if !isStartTime{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true);
            isStartTime = true
        }
    }
    
    func reset(){
        self.end()
        self.totalTime = EggTimer.prefTime
    }
    
    func end(){
        isStartTime = false
        timer.invalidate()
    }
    
    func isStopped() -> Bool {
        print(isStartTime)
        return (totalTime < EggTimer.prefTime) && !isStartTime
    }
    @objc func timerAction(){
        totalTime -= 100
        if totalTime == 0{
            end()
        }
        if timerUpdate != nil{
            timerUpdate!.updateTime(totalTime: totalTime)
        }
    }
}
