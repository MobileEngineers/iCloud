//
//  OrganizaData.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import Foundation
import CloudKit

class OrganizaData {
    
    private var dias = [NSDate]()
    private var tarefas = [TarefaCloud]()
    private var diasEProvas = [NSDate : [String]]()
    
    func configurar(tarefa : [TarefaCloud])
    {
        self.tarefas = tarefa
        self.geraArrayDias()
        self.geraDicionario()
    }
    
    private func geraArrayDias()
    {
        var diaSet = Set(self.dias)
        for tarefa in tarefas {
            for dia in tarefa.data {
                if !diaSet.contains(dia) {
                    diaSet.insert(dia)
                }
            }
        }
        self.dias = Array(diaSet)
        self.dias.sort() { $0.compare( $1 ) == NSComparisonResult.OrderedAscending }
    }
    
    private func geraDicionario()
    {
        for tarefa in self.tarefas {
            for dia in tarefa.data {
                self.diasEProvas[dia] = []
            }
        }
        for tarefa in self.tarefas {
            for dia in tarefa.data {
                var arrayNomes = self.diasEProvas[dia]
                arrayNomes!.append(tarefa.nome)
                self.diasEProvas[dia] = arrayNomes
            }
        }
    }
    
    func getNumeroSecoes() -> Int
    {       return self.dias.count      }
    
    func getNumeroLinhasSecao( secao: Int) -> Int
    {
        let dia = self.dias[secao]
        return self.diasEProvas[dia]!.count
    }
    
    func getDiaProva(secao : Int) -> NSDate
    {       return self.dias[secao]     }
    
    func getNomesTarefa(secao : Int, linha : Int) -> String
    {
        let dia = self.dias[secao]
        return self.diasEProvas[dia]![linha]
    }
    
    func getTarefaByNome(nome: String) -> TarefaCloud?
    {
        for tarefa in tarefas
        {
            if tarefa.nome == nome
            {       return tarefa       }
        }
        return nil
    }
   
}
