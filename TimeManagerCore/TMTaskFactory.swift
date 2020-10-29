//
//  TMTask.swift
//  TimeManagerCore
//
//  Created by Sergey Borovkov on 29.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation


class TMTaskFactory {

    func CreateTask(name: String, minutes: Int, period: TaskPeriod, _ isSplitNeeded: Bool) -> TMTask {
        return TMTask(name: name, minutes: minutes, period: period, isSplitNeeded)
    }
  
    private func SaveTask(task: TMTask) -> Void {
        // todo add saving in DB
    }
}
