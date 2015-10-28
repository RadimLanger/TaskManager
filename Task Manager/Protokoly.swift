//
//  Protokol.swift
//  Task Manager
//
//  Created by Radim Langer on 22/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import Foundation

// Abychom mohli predavat data z obou pickeru do taskviewcontrolleru a i z nej do categorypickerviewcontrolleru 
protocol changeDateCategValuesDelegate: class {
    func changeCategory(toValue: String)
    func changeDate(toValue: String)
}

