//
//  CloudKitHelper.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import Foundation
import CloudKit

protocol CloudKitHelperDelegate
{
    func errorUpdating(error: NSError)
    func modelUpdated()
}

@objc class CloudKitHelper {
    
    class func sharedInstance() -> CloudKitHelper
    {       return CloudKitHelperSingleton      }

    var delegate: CloudKitHelperDelegate?
    
    var disciplinas = [DisciplinaCloud]()
    var avaliacao = [AvaliacaoCloud]()
    var tarefa = [TarefaCloud]()
    
    let container: CKContainer
    let privateDB: CKDatabase
    
    init()
    {
        container = CKContainer.defaultContainer()
        privateDB = container.privateCloudDatabase
    }
    
    func refreshDisciplina() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Disciplina", predicate: predicate)

        privateDB.performQuery(query, inZoneWithID: nil)
    {           results, error in
            if error != nil
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else
        {
                self.disciplinas.removeAll(keepCapacity: true)
                for record in results
            {
                    let disciplina = DisciplinaCloud(record: record as! CKRecord, database:self.privateDB)
                    self.disciplinas.append(disciplina)
                    
                    //CORE DATA
                    dispatch_async(dispatch_get_main_queue())
                {
                        var disciplinaCD = DisciplinaManager.sharedInstance.newDisciplina()
                        disciplinaCD.nome = disciplina.nome

                        DisciplinaManager.sharedInstance.salvarDisciplina()
                    
                }
                dispatch_async(dispatch_get_main_queue())
                {
                    self.delegate?.modelUpdated()
                    println()
                }
            }
        }
    }
}
    
    func refreshAvaliacao() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Avalicao", predicate: predicate)
        
        privateDB.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else {
                self.avaliacao.removeAll(keepCapacity: true)
                for record in results {
                    let avaliacoes = AvaliacaoCloud(record: record as! CKRecord, database:self.privateDB)
                    self.avaliacao.append(avaliacoes)
                    
                    //CORE DATA
                    dispatch_async(dispatch_get_main_queue()){
                        var avaliacaoCD = AvaliacaoManager.sharedInstance.newAvaliacao()
                        avaliacaoCD.nome = avaliacoes.nome
                        //avaliacaoCD.check = avaliacoes.check
                        avaliacaoCD.data = avaliacoes.data
                        avaliacaoCD.materia = avaliacoes.materia!
                        avaliacaoCD.nota = avaliacoes.nota!
                       
                        AvaliacaoManager.sharedInstance.salvarAvaliacao()
                    
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    println()
                }
            }
        }
    }
}
    
    func refreshTarefa() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Tarefa", predicate: predicate)
        
        privateDB.performQuery(query, inZoneWithID: nil)
        {   results, error in
            if error != nil
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else
            {
                self.tarefa.removeAll(keepCapacity: true)
                for record in results
                {
                    let tarefas = TarefaCloud(record: record as! CKRecord, database:self.privateDB)
                    self.tarefa.append(tarefas)
                    
                    //CORE DATA
                    dispatch_async(dispatch_get_main_queue())
                        {
                        var tarefaCD = TarefaManager.sharedInstance.novaTarefa()
                        tarefaCD.nome = tarefas.nome
                        //tarefaCD.check = tarefas.check
                        tarefaCD.data = tarefas.data
                        tarefaCD.descricao = tarefas.materia!
                        tarefaCD.nota = tarefas.nota!
                        
                        TarefaManager.sharedInstance.salvarTarefa()
                        }
                    
                dispatch_async(dispatch_get_main_queue())
                    {       self.delegate?.modelUpdated()      }
                }
            }
        }
    }
}

let CloudKitHelperSingleton = CloudKitHelper()