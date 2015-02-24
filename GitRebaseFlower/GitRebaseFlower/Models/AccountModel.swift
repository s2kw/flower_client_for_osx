//
//  AccountModel.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 2/20/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation
import AppKit

class AccountModel: NSObject {
    var name: String
    var token: String
    
    required override init() {
        self.name = "account default name"
        self.token = "default token"
    }
}

