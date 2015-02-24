//
//  BranchModel.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 2/20/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation
import AppKit

class BranchModel: NSObject {
    var name: String
    var author: String
    var current: Bool
    var change: Bool
    var parent: BranchModel!
    
    override init() {
        self.name   = "test"
        self.author = "default author"
        self.current    = false
        self.change = false
        self.parent = nil
    }
}

