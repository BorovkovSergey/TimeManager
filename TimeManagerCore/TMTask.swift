//
//  TMTask.swift
//  TimeManagerCore
//
//  Created by Sergey Borovkov on 29.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation


extension Date {
    func daysInMonth() -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = Calendar.current.component(.year,  from: self)
        dateComponents.month = Calendar.current.component(.month,  from: self)
        if
            let d = Calendar.current.date(from: dateComponents),
            let interval = Calendar.current.dateInterval(of: .month, for: d),
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day
        { return days } else { return -1 }
    }
}

enum TaskPeriod {
    case daily
    case monthly
    case weekly
}

fileprivate let daysInWeek = 7

class TMTask {
    init(name: String, minutes: Int, period: TaskPeriod, _ isSplitNeeded: Bool){
        taskName = name
        switch period {
        case .daily:
            minutesDaily = minutes
        case .weekly:
            minutesWeekly = minutes
            if isSplitNeeded {
                minutesDaily = minutesWeekly / daysInWeek
            }
        case .monthly:
            minutesMonthly = minutes
            if isSplitNeeded {
                let date = Date()
                minutesDaily = minutesMonthly / date.daysInMonth()
                minutesWeekly = minutesDaily * daysInWeek
            }
        }
    }
    
    convenience init(
        name: String,
        minutes: Int,
        period: TaskPeriod,
        _ isSplitNeeded: Bool,
        mdr: Int,
        mwr: Int,
        mmr: Int
        ){
        self.init(name: name, minutes: minutes, period: period, isSplitNeeded)
        minutesDailyReached = mdr
        minutesWeeklyReached = mwr
        minutesMonthlyReached = mmr
    }
    
    private var minutesDaily : Int = 0
    private var minutesWeekly : Int = 0
    private var minutesMonthly : Int = 0

    private var minutesDailyReached : Int = 0
    private var minutesWeeklyReached : Int = 0
    private var minutesMonthlyReached : Int = 0
    
    func AddMinutes( count: Int ) -> Void{
        minutesDailyReached += count
        minutesWeeklyReached += count
        minutesMonthlyReached += count
    }
    
    private var taskName : String = "Empty"
    var name : String {
        get{
            return taskName
        }
        set{
            // todo add checking that name is unique
            taskName=newValue
        }
    }
    
    var maxValue : Int {
        get{
            return minutesDaily // todo fix me
        }
    }
    var minutesReached : Int {
        get{
            return minutesDailyReached // todo fix me
        }
    }
    
    static func == (left: TMTask, right: TMTask) -> Bool {
        return left.name == right.name ? true : false
    }
}
