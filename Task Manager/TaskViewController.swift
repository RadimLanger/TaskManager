//
//  NewTaskTableViewController.swift
//  Task Manager
//
//  Created by Radim Langer on 15/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, changeDateCategValuesDelegate {

    var task: Task?
/*
    var colorsArray = ["black.png","blue.png","brown.png","cyan.png"]
*/
    
    @IBOutlet weak var textFieldTaskName: UITextField! { didSet { textFieldTaskName.delegate = self } }
    @IBOutlet weak var categoryNewButton: UIButton!
    @IBOutlet weak var dateNewButton: UIButton!
    @IBOutlet weak var saveNewTaskButton: UIBarButtonItem!
    @IBOutlet weak var categoryColorImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Jako prvni nam vyjede klavesnice, na nazev tasku
        textFieldTaskName.becomeFirstResponder()
        // Nastavime pohled, kdyz editujeme existujici task
        if let task = task {
            navigationItem.title = task.name
            textFieldTaskName.text = task.name
            categoryNewButton.setTitle(task.category, forState: UIControlState.Normal)
            dateNewButton.setTitle(task.date, forState: UIControlState.Normal)
        }
        // Povolime tlacitko Save jen pokud neni prazdny nazev noveho tasku
        checkValidName()
        textFieldTaskName.delegate = self
        // Nastavime obrazek/barvu kategorie
        setColor()
    }
    
    // Mark: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Bool - Bylo zmacknuto plusko?
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        if isPresentingInAddTaskMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Identity operator
        if saveNewTaskButton === sender {
            //Ziskavani potrebnych informaci na zobrazeni
            let taskNew = textFieldTaskName.text
            let categoryNew = categoryNewButton.currentTitle
            let dateNew = dateNewButton.currentTitle
            
            task = Task(name: taskNew!, date: dateNew!, color: setColor(), category: categoryNew!, check: false, checkImg: "unchecked.png", notification: false)
        }
        // Pokud jdeme vybirat kategorii, musime poslat nazev stavajiciho tlacitka a chceme dostat vybranou hodnotu zpet pres delegate
        if(segue.identifier == "showCategory") {
            let picker = (segue.destinationViewController as! CategoryPickerViewController)
            // Posilame defaultni nazev tlacitka do categorypickerviewcontrolleru
            picker.categorySelected = categoryNewButton.currentTitle!
            picker.delegate = self
        }
        if(segue.identifier == "showDate") {
            let picker = (segue.destinationViewController as! DatePickerViewController)
            picker.delegate = self
        }
        
    }

    // Menime datum
    func changeDate(toValue: String) {
        dateNewButton.setTitle(toValue, forState: UIControlState.Normal)
    }
    // Menime nazev tlacitka kategorie
    func changeCategory(toValue: String) {
        categoryNewButton.setTitle(toValue, forState: UIControlState.Normal)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        saveNewTaskButton.enabled = false
    }

    func checkValidName() {
        // Tlacitko save povolime jen, kdyz uzivatel neco napise do nazvu tasku
        saveNewTaskButton.enabled = !textFieldTaskName.text!.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        // Zmenime jeste titulek navigacniho baru pri zmene textu a kliknuti jinam
        navigationItem.title = textField.text
    }

    // Kdyz vybereme z pickeru kategorii, updatne se obrazek
    @IBAction func unwindToDetailFromPicker(sender: UIStoryboardSegue) {
        setColor()
    }
    
    // Menime obrazky kategorie (barvy), zatim natvrdo nastavene
    func setColor() -> String {
        switch categoryNewButton.currentTitle! {
        case "Job":
            categoryColorImage.image = UIImage(named: "black.png")
            return "black.png"
        case "School":
            categoryColorImage.image = UIImage(named: "blue.png")
            return "blue.png"
        case "Home":
            categoryColorImage.image = UIImage(named: "brown.png")
            return "brown.png"
        case "Free time":
            categoryColorImage.image = UIImage(named: "green.png")
            return "green.png"
        default:
            return ""
        }
    }

    // MARK: - Po tapnuti na return se klavesnice sama nevrati, pomocne fce, aby se vracela
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // Schova klavesnici
        textFieldTaskName.resignFirstResponder()
        return true
    }
    // Po tapnuti jinde nez na klavesnici, se diky teto fci take vrati
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first as UITouch! {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
}
