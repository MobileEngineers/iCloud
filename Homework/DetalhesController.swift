//
//  DetalhesController.swift
//  
//
//  Created by Isaías Lima on 09/06/15.
//
//

import UIKit

protocol DetalhesDelegate {
    
    func adicionaProva(nome: String, descricao: String, data: NSDate)
    
    func adicionaTrabalho(nome: String, descricao: String, entrega: NSDate)
    
}

class DetalhesController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var delegate: DetalhesDelegate!

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var textView: UITextView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var salvar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = NSDate()
        salvar.enabled = false
        textField.delegate = self
        textView.delegate = self
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        salvar.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        textView.resignFirstResponder()
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    */
    @IBAction func salvarTarefa(sender: AnyObject) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            delegate.adicionaProva(textField.text, descricao: textView.text, data: datePicker.date)
            let cadastro = UIAlertController(title: "Tarefa adicionada", message: "Comece a estudar", preferredStyle: .Alert)
            
            let cancelar: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel)
                {   action -> Void in cadastro.dismissViewControllerAnimated(true, completion: nil)
                    cadastro.dismissViewControllerAnimated(true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)           }
            
            cadastro.addAction(cancelar)
            
            self.presentViewController(cadastro, animated: true, completion: nil)
        }
        if segmentedControl.selectedSegmentIndex == 1 {
            delegate.adicionaTrabalho(textField.text, descricao: textView.text, entrega: datePicker.date)
            let cadastro = UIAlertController(title: "Tarefa adicionada", message: "Comece a escrever", preferredStyle: .Alert)
            
            let cancelar: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel)
                {   action -> Void in
                    cadastro.dismissViewControllerAnimated(true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)           }
            
            cadastro.addAction(cancelar)
            
            self.presentViewController(cadastro, animated: true, completion: nil)
        }
        
    }
    @IBAction func cancelar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
