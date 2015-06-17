//
//  NotasController.swift
//  
//
//  Created by Isaías Lima on 16/06/15.
//
//

import UIKit
import CoreData

class NotasController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    
    var prova: String!
    var trabalho: String!
    var disciplina: String!
    var disciplinas: [Disciplina]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        var request = NSFetchRequest(entityName: "Disciplina")
        request.returnsObjectsAsFaults = false
        
        disciplinas = CoreData.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: nil) as! [Disciplina]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBAction func atualizar(sender: AnyObject) {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let string = NSString(format: "%@", textField.text)
            var nota = string.doubleValue
            if (nota > 10.0) { nota = 10.0 }
            if (nota < 0.0)  { nota = 0.0  }
            
            for materia in disciplinas {
                if materia.nome == disciplina {
                    if prova != nil {
                        let provas = materia.avaliacoes.allObjects as! [Avaliacao]
                        for avaliacao in provas {
                            if avaliacao.nome == self.prova {
                                avaliacao.setValue(nota, forKey: "nota")
                                CoreData.sharedInstance.managedObjectContext!.save(nil)
                            }
                        }
                        
                    }
                    if trabalho != nil {
                        let trabalhos = materia.trabalhos.allObjects as! [Trabalho]
                        for tarefa in trabalhos {
                            if tarefa.nome == self.trabalho {
                                tarefa.setValue(nota, forKey: "nota")
                                CoreData.sharedInstance.managedObjectContext!.save(nil)
                            }
                        }
                        
                    }
                }
            }
            
            let cadastro = UIAlertController(title: "Nota cadastrada", message: "", preferredStyle: .Alert)
            
            let cancelar: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel)
                {   action -> Void in }
            
            cadastro.addAction(cancelar)
            
            self.presentViewController(cadastro, animated: true, completion: nil)
            
        }
        
    }




}
