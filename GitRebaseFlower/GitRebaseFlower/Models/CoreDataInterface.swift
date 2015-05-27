//
//  CoreDataInterface.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 5/28/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation
import CoreData

class CoreDataInterface : NSManagedObject{
    @NSManaged var identity: String
    @NSManaged var userName: String?
    @NSManaged var pass: String?
}