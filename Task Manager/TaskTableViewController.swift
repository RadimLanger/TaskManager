//
//  MainTableViewController.swift
//  Task Manager
//
//  Created by Radim Langer on 14/09/15.
//  Copyright (c) 2015 Radim Langer. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController {

    // Outlet taskTableView
    @IBOutlet var taskTableView: UITableView!
    // Outlet checkboxu
    @IBAction func checker(sender: UIButton) {
        // Znegujeme stavajici hodnotu na false
        arrayOfTasks[sender.tag].check = !arrayOfTasks[sender.tag].check
        // Upravime obrazek
        changeCheckImg(arrayOfTasks[sender.tag].check, sender: sender.tag)
        // Reloadneme data
        tableView.reloadData()
        //       Todo: 
        //
    }
    
    // Seznam tasku
    var arrayOfTasks = [Task]()
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    override func viewDidLoad() {

        // Mark: - Tvoreni dvou tlacitek v navigacnim baru v pravo
        // znak u{2699} je ozubene kolecko
        let rightSettingsBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "\u{2699}", style: UIBarButtonItemStyle.Done, target: self, action: "tabBarSettingsClicked")
        
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "tabBarAddClicked")
        
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightSettingsBarButtonItem], animated: true)

        // inicializace tasku
        self.setupTask()
    }

    // Menime obrazek checkboxu podle boolu
    func changeCheckImg(checkBool: Bool, sender: Int) {
        if checkBool {
            arrayOfTasks[sender].checkImg = "checked.png"
        } else {
            arrayOfTasks[sender].checkImg = "unchecked.png"
        }
    }

    // Pridavani tasku pres metodu setupTasks
    
    func setupTask() {
        arrayOfTasks.append(Task(name: "DU Matika", date: "9/23/15, 7:51 PM", color: "green.png", category: "Home", check: false, checkImg: "unchecked.png", notification: true))
        arrayOfTasks.append(Task(name: "DU Dejepis", date: "9/23/15, 7:51 PM", color: "purple.png", category: "School", check: true, checkImg: "checked.png", notification: false))
        arrayOfTasks.append(Task(name: "DU Ajina", date: "9/23/15, 7:51 PM", color: "black.png", category: "Job", check: false, checkImg: "unchecked.png", notification: true))

        
        
        
        let jsonObject: [AnyObject] = [
            ["name":arrayOfTasks[0].name,
             "date":arrayOfTasks[0].date,
             "color":arrayOfTasks[0].color,
             "category":arrayOfTasks[0].category,
             "check":arrayOfTasks[0].check,
             "checkImg":arrayOfTasks[0].checkImg,
             "notification":arrayOfTasks[0].notification
            
            ]
            
            
        
        
        
        ]
        
        //print("\"name\":\"\()\",\n\"date\":\"\(arrayOfTasks[0].date)\",\n\"color\":\(arrayOfTasks[0].color)\",\n\"category\":\(arrayOfTasks[0].category)\",\n\"check\":\(arrayOfTasks[0].check),\n\"checkImg\":\"\(arrayOfTasks[0].checkImg)\",\n\"notification\":\(arrayOfTasks[0].notification)")
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
        // Pridame tag kazdemu checkboxu, abychom je pak rozeznali od sebe
        cell.mainIsDone.tag = indexPath.row

        cell.setTaskCell(task.name, datum: task.date, barva: task.color, hotovo: task.checkImg)
        
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
        _ = arrayOfTasks[indexPath.row]
    }
    
    
    // Pridavame nove tasky, nebo upravujeme stavajici po zmacknuti tlacitka Save
    @IBAction func unwindToMainFromNew(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? TaskViewController, task = sourceViewController.task {
            // Pokud chceme upravit stavajici task
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
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
