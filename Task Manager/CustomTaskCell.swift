//
//  CustomTaskCell.swift
//  Task Manager
//
//  Created by Radim Langer on 15/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

//Pomocna trida pro customTableView

class CustomTaskCell: UITableViewCell {

    @IBOutlet weak var mainName: UILabel!
    @IBOutlet weak var mainDate: UILabel!
    @IBOutlet weak var mainColor: UIImageView!
    @IBOutlet weak var mainIsDone: UIButton!
    
    func setTaskCell(jmeno: NSString, datum: NSString, barva: NSString, hotovo: NSString) {
        self.mainName.text = jmeno as String
        self.mainDate.text = datum as String
        self.mainColor.image = UIImage(named: barva as String)
        self.mainIsDone.setImage(UIImage(named: hotovo as String), forState: UIControlState.Normal)
    }
}
