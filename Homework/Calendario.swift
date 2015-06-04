//
//  Calendario.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit

class Calendario: UITableViewController, CloudKitHelperDelegate {
    
    let model = CloudKitHelper.sharedInstance()
    let organiza = OrganizaData()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.delegate = self
        
        self.organiza.configurar(model.tarefa)
        
        if model.tarefa.count == 0
        {
            let alert = UIAlertView(title: "Oops, deu ruim!",
                message: "Você não está conectado à rede de dados", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    override func didReceiveMemoryWarning()
    {       super.didReceiveMemoryWarning()     }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {       return organiza.getNumeroSecoes()       }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {       return organiza.getNumeroLinhasSecao(section)       }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let diaProva = dateFormatter.stringFromDate(organiza.getDiaProva(section))
        return diaProva
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaCalendario", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = organiza.getNomesTarefa(indexPath.section, linha: indexPath.row)
        
        return cell
    }
    
    //MARK: - CloudKitHelper Delegate
    
    func modelUpdated()
    {
        
    }
    
    func errorUpdating(error: NSError)
    {
        
    }
    
}
