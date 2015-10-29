//
//  Tasks.swift
//  Task Manager
//
//  Created by Radim Langer on 15/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import Foundation

class Task {

    var name: String
    var date: String
    var color: String
    var category: String
    var check: Bool
    var checkImg: String
    var notification: Bool
    
    init(name: String, date: String, color: String, category: String, check: Bool, checkImg: String, notification: Bool){
        self.name = name
        self.date = date
        self.color = color
        self.category = category
        self.check = check
        self.checkImg = checkImg
        self.notification = notification
    }
}