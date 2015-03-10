//
//  Config.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 3/10/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation

class Config: NSObject {
    var repo : String?
    var gituser : String?
    var gitpass : String?
    var workingDir : String?

    let repo_key        : String
    let gituser_key     : String
    let gitpass_key     : String
    let workingDir_key  : String

    required override init() {
        self.repo_key = "repo";
        self.gituser_key = "gituser";
        self.gitpass_key = "gitpass";
        self.workingDir_key = "workingDir";
        
        let config = NSUserDefaults.standardUserDefaults();
        
        self.repo       = config.objectForKey( self.repo_key ) as NSString;
        self.gituser    = config.objectForKey( self.gituser_key ) as NSString;
        self.gitpass    = config.objectForKey( self.gitpass_key ) as NSString;
        self.workingDir = config.objectForKey( self.workingDir_key ) as NSString;
    }
}