//
//  Trabalho.swift
//  Homework
//
//  Created by Isaías Lima on 03/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import Foundation
import CoreData

class Trabalho: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var data: NSDate
    @NSManaged var nota: Double
    @NSManaged var descricao: String
    @NSManaged var check: Bool
    @NSManaged var disciplina: Disciplina

}
