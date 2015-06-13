//
//  RelatoriosTableView.swift
//  Homework
//
//  Created by Lidia Chou on 6/5/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData

class RelatoriosTableView: UITableViewController {
    
    var disciplinas: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = NSFetchRequest(entityName: "Disciplina")
        request.returnsObjectsAsFaults = false
        
        disciplinas = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        var request = NSFetchRequest(entityName: "Disciplina")
        request.returnsObjectsAsFaults = false
        
        disciplinas = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplinas.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Suas Disciplinas"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("disciplina", forIndexPath: indexPath) as! UITableViewCell
        let disciplina = disciplinas.objectAtIndex(indexPath.row) as! Disciplina
        cell.textLabel?.text = disciplina.nome
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = tableView.indexPathForSelectedRow()
        let viewController = segue.destinationViewController as! SelecionaRelatorioTableView
        
        viewController.disciplina = disciplinas.objectAtIndex(indexPath!.row) as! Disciplina
        
    }
    

}
