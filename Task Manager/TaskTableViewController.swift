//
//  MainTableViewController.swift
//  Task Manager
//
//  Created by Radim Langer on 14/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {


    // Outlet taskTableView
    @IBOutlet var taskTableView: UITableView!

    // Seznam tasku
    var arrayOfTasks = [Task]()
    
    
    override func viewDidLoad() {

        // Mark: - Tvoreni dvou tlacitek v navigacnim baru v pravo
        
        var rightSettingsBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.Action, target: self, action: "tabBarSettingsClicked")

        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "tabBarAddClicked")
        
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightSettingsBarButtonItem], animated: true)

        // inicializace tasku
        self.setupTask()


    }

    // Pridavani tasku pres metodu setupTasks
    
    func setupTask() {
        arrayOfTasks.append(Task(name: "DU Matika", date: "21.2.2014", color: "green.png", category: "Home", check: "unchecked.png", notification: true))
        arrayOfTasks.append(Task(name: "DU Dejepis", date: "2.12.2016", color: "purple.png", category: "School", check: "unchecked.png", notification: false))
        arrayOfTasks.append(Task(name: "DU Ajina", date: "22.1.2017", color: "whiteblue.png", category: "Job", check: "checked.png", notification: true))
    }
    
    
    // MARK: - Navigaton
    
    func tabBarSettingsClicked(){
        performSegueWithIdentifier("showSettings", sender: self)
    }

    func tabBarAddClicked(){
        performSegueWithIdentifier("showNewTask", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailTask" {
            // volame segue jako taskviewcontroller
            let taskDetailController = segue.destinationViewController as! TaskViewController
            // Dostaneme bunku, ktera vola seque
            if let selectedTaskCell = sender as? CustomTaskCell {
                let indexPath = tableView.indexPathForCell(selectedTaskCell)
                let selectedTask = arrayOfTasks[indexPath!.row]
                taskDetailController.task = selectedTask
            }
        } 
    }
    
    // MARK: - Table View nastaveni
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: CustomTaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as! CustomTaskCell

        let task = arrayOfTasks[indexPath.row]
        
        cell.setTaskCell(task.name, datum: task.date, barva: task.color, hotovo: task.check)
        
        return cell
    }
    
    // Na mazani jednotlivych tasku pomoci swipu
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            arrayOfTasks.removeAtIndex(indexPath.row)
            self.taskTableView.reloadData()
        }
    }

    // TaskDetail
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let task = arrayOfTasks[indexPath.row]
    }
    
    
    // Pridavame nove tasky, nebo upravujeme stavajici po zmacknuti tlacitka Save
    @IBAction func unwindToMainFromNew(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? TaskViewController, task = sourceViewController.task {
            // Pokud chceme upravit stavajici task
            if let selectedIndexPath = tableView.indexPathForSelectedRow() {
                arrayOfTasks[selectedIndexPath.row] = task
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            } // Pokud chceme vytvorit novy task
            else {
            // Musime zjistit na jaky index to dame
            let newIndexPath = NSIndexPath(forRow: arrayOfTasks.count, inSection: 0)
            // Strcime novy task do tabulky
            arrayOfTasks.append(task)
            // Supneme ji na konec tableView
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
        
    }
    
    
}
