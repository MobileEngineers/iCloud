//
//  RelatorioProvaTarefaTableView.swift
//  Homework
//
//  Created by Lidia Chou on 6/17/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit

class RelatorioProvaTarefaTableView: UITableViewController {
    
    var prova: Avaliacao!
    var trabalho: Trabalho!
    
    @IBOutlet var nome: UILabel!
    @IBOutlet var texto: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var feita: UILabel!
    @IBOutlet var nota: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if prova != nil {
            
            nome.text = prova.nome
            texto.text = prova.materia
            datePicker.date = prova.data
            if prova.nota != -1.0 {
                feita.text = "Sim"
                feita.textColor = UIColor.greenColor()
                nota.text = "\(prova.nota)"
            } else {
                feita.text = "Não"
                feita.textColor = UIColor.redColor()
                nota.text = "Não feita/Em correção"
            }
            
        }
        if trabalho != nil {
            
            nome.text = trabalho.nome
            texto.text = trabalho.descricao
            datePicker.date = trabalho.data
            if trabalho.nota != -1.0 {
                feita.text = "Sim"
                feita.textColor = UIColor.greenColor()
                nota.text = "\(trabalho.nota)"
            } else {
                feita.text = "Não"
                feita.textColor = UIColor.redColor()
                nota.text = "Não feito/Em correção"
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
