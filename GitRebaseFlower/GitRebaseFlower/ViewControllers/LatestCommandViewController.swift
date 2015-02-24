//
//  LatestCommandViewController.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 2/24/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import AppKit
import Foundation

class LatestCommandViewController: NSViewController {
    
    @IBOutlet weak var commandField: NSTextField!
    
    override func viewDidLoad() {
    }
    
    func updateLatestCommand( _command :String ){
        self.commandField.stringValue = _command;
    }
}