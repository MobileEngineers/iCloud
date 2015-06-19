//
//  TarefasController.swift
//  Homework
//
//  Created by Isaías Lima on 06/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class TarefasController: UITableViewController, DetalhesDelegate {
    
    var disciplina: Disciplina!
    var trabalhos: NSArray!
    var provas: NSArray!
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate
            as? AppDelegate
        
    }
    
    override func viewWillAppear(animated: Bool) {
        provas = disciplina.avaliacoes.allObjects
        trabalhos = disciplina.trabalhos.allObjects
        
        self.navigationItem.title = disciplina.nome
        self.tableView.reloadData()
    }
    
    
    func adicionaProva(nome: String, descricao: String, data: NSDate, error: NSErrorPointer) {
        //Adicionando Evento
        var event: EKEvent?
        
        if Calendar.Authorization() {
            event = Calendar.addEvent("\(disciplina.nome) - \(nome)", notes: descricao, date: data)
        }
        
        
        let novaProva = NSEntityDescription.insertNewObjectForEntityForName("Avaliacao", inManagedObjectContext: CoreData.sharedInstance.managedObjectContext!) as! Avaliacao
        novaProva.nome = nome
        novaProva.materia = descricao
        novaProva.data = data
        novaProva.nota = -1.0
        novaProva.eventIdentifier = event!.eventIdentifier
        disciplina.avaliacoes = disciplina.avaliacoes.setByAddingObject(novaProva)
        
        CoreData.sharedInstance.managedObjectContext!.save(nil)
        
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = data.dateByAddingTimeInterval(-7*24*60*60)
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = "Não se esqueça de estudar"
        localNotification.alertAction = "Ver"
        localNotification.alertTitle = nome
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.repeatInterval = NSCalendarUnit.CalendarUnitDay
        println(localNotification.fireDate)
        println(localNotification.userInfo)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        
        self.tableView.reloadData()
    }
    
    func adicionaTrabalho(nome: String, descricao: String, entrega: NSDate) {
        //Adicionando Evento
        var event: EKEvent?
        
        if Calendar.Authorization() {
            event = Calendar.addEvent("\(disciplina.nome) - \(nome)", notes: descricao, date: entrega)
        }
        
        let novoTrabalho = NSEntityDescription.insertNewObjectForEntityForName("Trabalho", inManagedObjectContext: CoreData.sharedInstance.managedObjectContext!) as! Trabalho
        novoTrabalho.nome = nome
        novoTrabalho.descricao = descricao
        novoTrabalho.data = entrega
        novoTrabalho.nota = -1.0
        novoTrabalho.eventIdentifier = event!.eventIdentifier
        disciplina.trabalhos = disciplina.trabalhos.setByAddingObject(novoTrabalho)
        
        CoreData.sharedInstance.managedObjectContext!.save(nil)
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = entrega.dateByAddingTimeInterval(-7*24*60*60)
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = "Não se esqueça de escrever"
        localNotification.alertAction = "Ver"
        localNotification.alertTitle = nome
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.repeatInterval = NSCalendarUnit.CalendarUnitDay
        println(localNotification.fireDate)
        println(localNotification.userInfo)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
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
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.section == 0 {
                let alerta = UIAlertController(title: "Deletando avaliação", message: "Deseja realmente excluir essa avaliação?", preferredStyle: .ActionSheet)
                let sim: UIAlertAction = UIAlertAction(title: "Sim", style: UIAlertActionStyle.Destructive) { action -> Void in
                    
                    let prova = self.provas.objectAtIndex(indexPath.row) as! Avaliacao
                    
                    //remover evento do calendário
                    Calendar.removeEvent(prova.eventIdentifier, error: nil)
                    
                    var notifications = UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification]
                    
                    for notification in notifications {
                        if notification.alertTitle == prova.nome {
                            UIApplication.sharedApplication().cancelLocalNotification(notification)
                        }
                    }
                    
                    CoreData.sharedInstance.managedObjectContext!.deleteObject(prova)
                    CoreData.sharedInstance.managedObjectContext!.save(nil)
                    
                    var request = NSFetchRequest(entityName: "Avaliacao")
                    request.returnsObjectsAsFaults = false
                    
                    var results: NSArray = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)!
                    self.provas = results
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    
                    var notifications = UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification]
                    
                    for notification in notifications {
                        if notification.alertTitle == prova.nome {
                            UIApplication.sharedApplication().cancelLocalNotification(notification)
                        }
                    }
                }
                alerta.addAction(sim)
                let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel) { action -> Void in self.tableView.reloadData()}
                alerta.addAction(cancelar)
                
                self.presentViewController(alerta, animated: true, completion: nil)
                
            } else {
                let alerta = UIAlertController(title: "Deletando tarefa", message: "Deseja realmente excluir essa tarefa?", preferredStyle: .ActionSheet)
                let sim: UIAlertAction = UIAlertAction(title: "Sim", style: UIAlertActionStyle.Destructive) { action -> Void in
                    
                    let trabalho = self.trabalhos.objectAtIndex(indexPath.row) as! Trabalho
                    
                    //remover evento do calendário
                    Calendar.removeEvent(trabalho.eventIdentifier, error: nil)
                    
                    var notifications = UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification]
                    
                    for notification in notifications {
                        if notification.alertTitle == trabalho.nome {
                            UIApplication.sharedApplication().cancelLocalNotification(notification)
                        }
                    }
                    
                    CoreData.sharedInstance.managedObjectContext!.deleteObject(trabalho)
                    CoreData.sharedInstance.managedObjectContext!.save(nil)
                    
                    var request = NSFetchRequest(entityName: "Trabalho")
                    request.returnsObjectsAsFaults = false
                    
                    var results: NSArray = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)!
                    self.trabalhos = results
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    
                    var notifications = UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification]
                    
                    for notification in notifications {
                        if notification.alertTitle == trabalho.nome {
                            UIApplication.sharedApplication().cancelLocalNotification(notification)
                        }
                    }
                }
                alerta.addAction(sim)
                let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel) { action -> Void in self.tableView.reloadData()}
                alerta.addAction(cancelar)
                
                self.presentViewController(alerta, animated: true, completion: nil)
                
            }
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
        
        if segue.identifier == "cadastro" {
            let viewController = segue.destinationViewController as! DetalhesController
            viewController.delegate = self
        }
        if segue.identifier == "tarefa" {
            let viewController = segue.destinationViewController as! NotasController
            viewController.disciplina = disciplina.nome
            
            let indexPath = tableView.indexPathForSelectedRow()
            
            if indexPath!.section == 0 {
                let prova = provas.objectAtIndex(indexPath!.row) as! Avaliacao
                viewController.prova = prova.nome
            }
            if indexPath!.section == 1 {
                let trabalho = trabalhos.objectAtIndex(indexPath!.row) as! Trabalho
                viewController.trabalho = trabalho.nome
            }
        }
        
    }
    
    
}
