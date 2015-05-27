//
//  Config.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 3/10/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation
import Cocoa

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
        
        self.repo       = config.objectForKey( self.repo_key ) as? String;

        if( self.repo == "" ){
            NSLog("self.repo is null")
        }

        self.gituser    = config.objectForKey( self.gituser_key ) as? String;
        self.gitpass    = config.objectForKey( self.gitpass_key ) as? String;
        self.workingDir = config.objectForKey( self.workingDir_key ) as? String;

        super.init()

    }
    
    func Serialize(){
        //var data: NSDate = NSData.new()
        var array: NSMutableArray = NSMutableArray.new()
        array.addObject( self.gituser! )
        array.addObject( self.gitpass! )
        
 //       let appDel: AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
//        let memoContext: NSManagedObjectContext = appDel.managedObjectContext!
//        let CoreDataInterface: NSEntityDescription! = NSEntityDescription.entityForName("CoreDataInterface", inManagedObjectContext: memoContext)
    }

    var managedObjectContext:CoreDataInterface?
    
    func saveContext () {
        var error: NSError? = nil
        let moc = self.managedObjectContext
        if moc == nil {
            return
        }
//        if !managedObjectContext.hasChanges {
//            return
//        }
//        if managedObjectContext.save(&amp;error) {
//            return
//        }
                
        println("Error saving context: \(error?.localizedDescription)\n\(error?.userInfo)")
        abort()
    }
    
    


}