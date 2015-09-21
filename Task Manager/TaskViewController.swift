//
//  NewTaskTableViewController.swift
//  Task Manager
//
//  Created by Radim Langer on 15/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, changeDateCatValuesDelegate {

    var task: Task?

    @IBOutlet weak var textFieldTaskName: UITextField! { didSet { textFieldTaskName.delegate = self } }
    @IBOutlet weak var categoryNewButton: UIButton!
    @IBOutlet weak var dateNewButton: UIButton!
    @IBOutlet weak var saveNewTaskButton: UIBarButtonItem!
    @IBOutlet weak var cancelNewTaskButton: UIBarButtonItem!
    
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
            
            task = Task(name: taskNew, date: dateNew!, color: "blue.png", category: categoryNew!, check: "unchecked", notification: false)
        }
        // Pokud jdeme vybirat kategorii, chceme dostat vybranou hodnotu zpet pres delegate
        if(segue.identifier == "showCategory") {
            var picker = (segue.destinationViewController as! PickerViewController)
            picker.delegate = self
        }
        
    }

    // Menime nazev tlacitka kategorie pri editu
    func changeCategory(toValue: String) {
        categoryNewButton.setTitle(toValue, forState: UIControlState.Normal)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        saveNewTaskButton.enabled = false
    }

    func checkValidName() {
        // Tlacitko save povolime jen, kdyz uzivatel neco napise do nazvu tasku
        saveNewTaskButton.enabled = !textFieldTaskName.text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        // Zmenime jeste titulek navigacniho baru pri zmene textu
        navigationItem.title = textField.text
    }
    
    // MARK: - Po tapnuti na return se klavesnice sama nevrati, pomocne fce, aby se vracela
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // Schova klavesnici
        textFieldTaskName.resignFirstResponder()
        return true
    }
    // Po tapnuti jinde nez na klavesnici, se diky teto fci take vrati
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
}
