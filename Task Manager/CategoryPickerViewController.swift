//
//  CategoryPickerViewController.swift
//  Task Manager
//
//  Created by Radim Langer on 18/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

class CategoryPickerViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var categoryPicker: UIPickerView!
    
    weak var delegate: changeDateCategValuesDelegate?
    // Pres delegaci posilame nazev tlacitka category
    var categorySelected: String?

    // Pocatecni kategorie
    var categories = ["School", "Home", "Job", "Free time"]

    // MARK: - Picker View nastaveni
    // Jedno kolecko
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    // Kolik kategorii v seznamu je
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return categories.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        // Jaky radek vybereme, ten se pak nastavi pro tlacitko kategorie v TaskTableViewControlleru
        categorySelected = categories[row]
    }
    
    @IBAction func cancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func confirm(sender: UIButton) {
        delegate?.changeCategory(categorySelected!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Zjistujeme na ktere pozici je
        let defaultRowIndex = categories.indexOf((categorySelected!))
        // Defaultni pozice pickeru
        categoryPicker.selectRow(defaultRowIndex!, inComponent: 0, animated: false)
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
