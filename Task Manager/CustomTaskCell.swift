//
//  CustomTaskCell.swift
//  Task Manager
//
//  Created by Radim Langer on 15/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

//Pomocna classa pro customTableView

class CustomTaskCell: UITableViewCell {

    @IBOutlet weak var mainName: UILabel!
    @IBOutlet weak var mainDate: UILabel!
    @IBOutlet weak var mainColor: UIImageView!
    @IBOutlet weak var mainIsDone: UIButton!
    
    func setTaskCell(jmeno: String, datum: String, barva: String, hotovo: String) {
        self.mainName.text = jmeno
        self.mainDate.text = datum
        self.mainColor.image = UIImage(named: barva)
        self.mainIsDone.setImage(UIImage(named: hotovo), forState: UIControlState.Normal)
    }
}
