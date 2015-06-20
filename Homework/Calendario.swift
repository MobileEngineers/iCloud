//
//  Calendario.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData
import EventKit



class Calendario: UIViewController, UITableViewDelegate, UITableViewDataSource/*, CloudKitHelperDelegate */ {
    
    var array1 = NSMutableArray()
    var array2 = NSMutableArray()
    var array3 = NSMutableArray()
    var array4 = NSMutableArray()
    var array5 = NSMutableArray()
    var array6 = NSMutableArray()
    var array7 = NSMutableArray()


    var disciplinas: NSArray!
    var atividades = NSMutableArray()

    @IBOutlet var tableView: UITableView!
    
    func organizarEmDia(atividade1: Atividade){
        
        let calendar = NSCalendar.currentCalendar()
        let comps = NSDateComponents()
        comps.day = 7
        let date2 = calendar.dateByAddingComponents(comps, toDate: NSDate(), options: NSCalendarOptions.allZeros)
        
        if atividade1.data.compare(date2!) == NSComparisonResult.OrderedDescending
        {
            NSLog("nao chegou em 7 dias");
        } else if atividade1.data.compare(date2!) == NSComparisonResult.OrderedAscending
        {
            NSLog("esta dentro de sete dias");
            array7.addObject(atividade1)

        } else
        {
            NSLog("esta no setimo dia");
            array7.addObject(atividade1)
            
            
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var request = NSFetchRequest(entityName: "Disciplina")
        request.returnsObjectsAsFaults = false
        
        array7.removeAllObjects()
        
        disciplinas = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil)
        println(disciplinas.count)
        for (var i = 0; i <= disciplinas.count - 1; i++){
            var disciplina  = disciplinas.objectAtIndex(i) as! Disciplina
            //
            println(disciplina.nome)
            //
            var todosTrabalhos = disciplina.trabalhos.allObjects as NSArray
            var todasProvas = disciplina.avaliacoes.allObjects  as NSArray
            println(todasProvas.count)
            println(todosTrabalhos.count)
            
            
            for (var i = 0; i <= todosTrabalhos.count - 1; i++){
                var trabalho1 = todosTrabalhos.objectAtIndex(i) as! Trabalho
                //
                println(trabalho1.nome)
                //
                var atividade1 = Atividade()
                atividade1.tipo = "trabalho"
                atividade1.nome = trabalho1.nome
                atividade1.data = trabalho1.data
                
                organizarEmDia(atividade1)
                
            }
            
            for (var i = 0; i <= todasProvas.count - 1; i++){
                var prova1 = todasProvas.objectAtIndex(i) as! Avaliacao
                //
                println(prova1.nome)
                //
                var atividade1 = Atividade()
                atividade1.tipo = "prova"
                atividade1.nome = prova1.nome
                atividade1.data = prova1.data
                organizarEmDia(atividade1)
                
            }
            tableView.reloadData()
            
        }
        
        
        
        //        array.sortedArrayUsingComparator { (objeto1, objeto2) -> NSComparisonResult in
        //            if objeto1 > objeto2
        //            return objeto1

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return array7.count
    
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        var atividade1 = array7.objectAtIndex(indexPath.row) as! Atividade
    cell.textLabel?.text = atividade1.nome
    
        return cell
    }
    

/*
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
*/
}
