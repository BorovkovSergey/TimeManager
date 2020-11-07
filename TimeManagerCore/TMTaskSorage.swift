//
//  TMTaskSorage.swift
//  TimeManagerCore
//
//  Created by Sergey Borovkov on 29.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation

class TMTaskStorage {
    
    private var tasks : [TMTask]
    private var tasksCount : Int = 0
    init(){
        tasks = [TMTask]()
        GetTasksFromDB()
    }
    
    private func GetTasksFromDB() -> Void{
        // todo add getting tasks from db
    }
    
    private func IsTaskExists( name: String ) -> Bool {
        for task in tasks {
            if task.name == name {
                return true
            }
        }
        return false
    }
    
    func CreateNewTask( name: String, minutes: Int, period: TaskPeriod, _ isSplitNeeded: Bool ) -> Void{
        if IsTaskExists(name: name) {
            return
        }
        tasks.append(TMTask( name: name, minutes: minutes, period: period, isSplitNeeded ))
        tasksCount += 1
    }
    
}
