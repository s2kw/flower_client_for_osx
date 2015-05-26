//
//  ViewController.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 2/18/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Cocoa
import Foundation

class ViewController: NSViewController {
    
    var track = Track()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("View Did Load");
        // Do any additional setup after loading the view.
        self.loadCommandView()
        self.textField.stringValue = " default ";
        var fm = NSFileManager();
        NSLog( fm.currentDirectoryPath );

    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var slider: NSSlider!
    
    @IBAction func mute(sender: AnyObject) {
        NSLog( "mute!" );
        track.volume = 0.0
        updateUserInterface()
        //textField.stringValue = shellScript()
    }
    
    
    @IBAction func takeFloatValueForVolumeFrom(sender: AnyObject) {
        NSLog(" push!!! " )
        if sender as! NSObject == slider
        {
            track.volume = slider.floatValue
        }
        else
        {
            track.volume = textField.floatValue
        }
        //updateUserInterface()
    }

    var commandViewController : LatestCommandViewController?;
    
    func shellScript() -> String {
        let task = NSTask()
        task.launchPath = "/usr/bin/git"
        task.currentDirectoryPath = "/workspace/repos/flower_client_for_osx"
        task.arguments = ["branch", "-a"]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        
        var command: String = "";
        for( var i = 0; task.arguments.count > i; i++ ){
            let s: String = command + (task.arguments[ i ] as! String) + " ";
            command = s;
            NSLog( String( i ) + ":" + s );
        }
        self.commandViewController?.updateLatestCommand( command );
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: NSString = NSString( data: data, encoding: NSUTF8StringEncoding )!
        
        let lines = output.componentsSeparatedByString("\n")
        for i in 0 ..< lines.count {
            let line: String = lines[i] as! String
            let components: String = line.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let oneLine = String( components )
            var branch :BranchModel = BranchModel()
            branch.name = ""
            branch.author = ""
            branch.current = self.isBranchNameHasAsterisk( oneLine )
            print( String( components ) + "\n" )
        }
        return output as String
        // assert(output == "first-argument second-argument\n")
    }
    func isBranchNameHasAsterisk( _branchName : String ) -> Bool{
        return true
    }
    
    func loadCommandView(){
        self.commandViewController = self.storyboard?.instantiateControllerWithIdentifier("LatestCommandViewController") as? LatestCommandViewController
        let positioned = NSWindowOrderingMode.Below
        let otherview: NSView  = self.view
        self.view.addSubview(
            self.commandViewController!.view,
            positioned: positioned,
            relativeTo: otherview )
        self.commandViewController?.updateLatestCommand( " default " );
    }
    
    func updateUserInterface()
    {
        let volume = track.volume
        textField.floatValue = volume
        slider.floatValue = volume
    }
}