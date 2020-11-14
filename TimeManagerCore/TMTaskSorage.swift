//
//  TMTaskSorage.swift
//  TimeManagerCore
//
//  Created by Sergey Borovkov on 29.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation

class TMTaskStorage {
    
    private var tasks_ : [TMTask]
    private var tasksCount_ : Int = 0
    init(){
        tasks_ = [TMTask]()
        GetTasksFromDB()
    }
    
    private func GetTasksFromDB() -> Void{
        // todo add getting tasks from db
    }
    
    private func IsTaskExists( name: String ) -> Bool {
        for task in tasks_ {
            if task.name == name {
                return true
            }
        }
        return false
    }
    
    func CreateNewTask( name: String, minutes: Int, period: TaskPeriod, _ isSplitNeeded: Bool ) -> Void{
        if IsTaskExists(name: name) {
            //todo add notification
            return
        }
        tasks_.append(TMTask( name: name, minutes: minutes, period: period, isSplitNeeded ))
        tasksCount_ += 1
    }
    
    var taskCount : Int {
        get{
            return tasksCount_
        }
    }
    
    public func GetTask( id: Int ) -> TMTask? {
        if id > tasksCount_ {
            print("Failed to get TMTask item id %d > tasks count %d", id, tasksCount_)
            return nil
        }
        return tasks_[id]
    }
    public func GetNewestTask( ) -> TMTask {
        return tasks_[ tasksCount_ - 1 ]
    }
}
