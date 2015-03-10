//
//  GitCommandModel.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 3/10/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation

class GitCommandModel: NSObject {
    var task : NSTask!
    required override init() {
        self.task = NSTask();
        self.task.launchPath = "/usr/bin/git"
        var fm = NSFileManager();
//        var s = NSFileManager.currentDirectoryPath;
//        self.task.currentDirectoryPath = s;
        
    }
}