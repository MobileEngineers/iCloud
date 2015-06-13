//
//  SelecionaRelatorioTableView.swift
//  Homework
//
//  Created by Lidia Chou on 6/5/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData

class SelecionaRelatorioTableView: UITableViewController {
    
    var disciplina: Disciplina!
    var trabalhos: NSArray!
    var provas: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        provas = disciplina.avaliacoes.allObjects
        trabalhos = disciplina.trabalhos.allObjects
        
        self.navigationItem.title = disciplina.nome
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return provas.count
        }
        if (section == 1) {
            return trabalhos.count
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tarefa", forIndexPath: indexPath) as! UITableViewCell
        
        if indexPath.section == 0 {
            
            let prova = provas.objectAtIndex(indexPath.row) as! Avaliacao
            cell.textLabel?.text = prova.nome
            
        }
        if indexPath.section == 1 {
            
            let trabalho = trabalhos.objectAtIndex(indexPath.row) as! Trabalho
            cell.textLabel?.text = trabalho.nome
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Avaliações"
        }
        if section == 1 {
            return "Trabalhos"
        }
        return ""
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
