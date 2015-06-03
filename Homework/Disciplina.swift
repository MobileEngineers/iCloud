//
//  Disciplina.swift
//  Homework
//
//  Created by Isaías Lima on 03/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import Foundation
import CoreData

class Disciplina: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var trabalhos: NSSet
    @NSManaged var avaliacoes: NSSet

}
