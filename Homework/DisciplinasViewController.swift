//
//  DisciplinasViewController.swift
//  Homework
//
//  Created by Isaías Lima on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData

class DisciplinasViewController: UITableViewController {
    
    var disciplinas: NSArray!
    var inputTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        var request = NSFetchRequest(entityName: "Disciplina")
        request.returnsObjectsAsFaults = false
        
        disciplinas = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        var request = NSFetchRequest(entityName: "Disciplina")
        request.returnsObjectsAsFaults = false
        
        disciplinas = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)
    }
    
    @IBAction func addDisciplina(sender: AnyObject) {
        let cadastro = UIAlertController(title: "Nova disciplina", message: "Teve uma ideia?", preferredStyle: .Alert)
        
        let salvar: UIAlertAction = UIAlertAction(title: "Salvar", style: .Default) { action -> Void in
            self.novaDisciplina(self.inputTextField!.text)
            cadastro.dismissViewControllerAnimated(true, completion: nil)
            self.tableView.reloadData()
        }
        cadastro.addAction(salvar)
        
        cadastro.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.textColor = UIColor.blackColor()
            textField.layer.cornerRadius = 2
            textField.placeholder = "Nome do projeto"
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
            self.inputTextField = textField
        }
        
        let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel) { action -> Void in
            cadastro.dismissViewControllerAnimated(true, completion: nil)
        }
        cadastro.addAction(cancelar)
        
        self.presentViewController(cadastro, animated: true, completion: nil)
    }
    
    func novaDisciplina(nome: String) {
        var newProjeto = NSEntityDescription.insertNewObjectForEntityForName("Disciplina", inManagedObjectContext: CoreData.sharedInstance.managedObjectContext!) as! NSManagedObject
        newProjeto.setValue(nome, forKey: "nome")
        
        disciplinas = disciplinas.arrayByAddingObject(newProjeto)
        
        CoreData.sharedInstance.managedObjectContext!.save(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return disciplinas.count
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
