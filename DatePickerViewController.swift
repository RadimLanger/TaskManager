//
//  DatePickerViewController.swift
//  Task Manager
//
//  Created by Radim Langer on 22/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController, UIPickerViewDelegate {

    let dateFormatter = NSDateFormatter()

    weak var delegate: changeDateCategValuesDelegate?
    var datum: String?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func cancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func datePickerChanged(sender: AnyObject) {
    }
    
    @IBAction func confirm(sender: UIButton) {
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle        
        datum = dateFormatter.stringFromDate(datePicker.date)
        delegate?.changeDate(datum!)
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
