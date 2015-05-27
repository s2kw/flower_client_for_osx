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
        println("View Did Load");
        // Do any additional setup after loading the view.
        self.loadCommandView()
        
        // 設定ファイルの読み込み

        //var rawStandards: NSDictionary = NSDictionary()?
        let name: String = "test"
        let ofType: String = "plist"
//        if let path = NSBundle.mainBundle().pathForResource( name, ofType: ofType ){
//            println( "currentWorkingPath : " + path )
//            //rawStandards = NSDictionary( contentsOfFile: path )?
//        }else{
//            println("file could not found")
//            // 設定ファイルが無かった場合
//            // projectの作成
//            self.createProjectFile( name )
//            
//            
//        }

        ProjectModel.Instance.CreateNewProjectFile("aaa");
        ProjectModel.Instance.CreateNewProjectFile("bbb");
        ProjectModel.Instance.CreateNewProjectFile("ccc");
        ProjectModel.Instance.CreateNewProjectFile("ddd");
        ProjectModel.Instance.CreateNewProjectFile("eee");
        ProjectModel.Instance.ReqruiteAllProjects();
        
        
        // 設定ファイルがあったけどパスが無かった
            // workspaceの決定
        
        
        // 設定ファイルのパスに.gitが無かった
            // git clone
        
        
        
        //self.textField.stringValue = " default ";
        var fm = NSFileManager();
        println( "file manager path" + fm.currentDirectoryPath );

    }
    internal var currentProjectInfo:NSDictionary!
    func createProjectFile( _projectName : String ){
        println("create project file as " + _projectName )
        let fileManager = NSFileManager.defaultManager()
        
        if var defaultFile = loadDefaultProjectFile() {
            defaultFile.setValue( _projectName, forKey:"ProjectName")
            if let saveTargetPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]{
                println("0 : " + saveTargetPaths[0])
                let dir = saveTargetPaths[0].stringByAppendingPathComponent("GitRevaseFlower");

                var err: NSErrorPointer = nil
                if fileManager.createDirectoryAtPath( dir , withIntermediateDirectories: false,attributes: nil, error: err ) {
                    println( "created : " + dir)
                }else{
                    println( "failed to create dir or directory is already exists.")
                }

                let projectFilePath = dir.stringByAppendingPathComponent( _projectName )
                if let projectFilePathAndExtention = projectFilePath.stringByAppendingPathExtension( "plist" ){
                    println("new project")
                    println(projectFilePathAndExtention)
                    defaultFile.writeToFile( projectFilePathAndExtention, atomically: false )
                }
            }else{
                println("project file could not create : " + _projectName )
            }
        }
    }
    func loadDefaultProjectFile() -> NSDictionary! {
        if let path = NSBundle.mainBundle().pathForResource( "DefaultProject", ofType: "plist" ){
            println( "default file in there :" + path )
            let defaultFile = NSDictionary( contentsOfFile: path )
            return defaultFile;
        }else{
            println("default file could not found");
        }
        return nil;
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var slider: NSSlider!
    
    @IBOutlet weak var button: NSButton!
    
    
    @IBAction func mute(sender: AnyObject) {
        println( "mute!" );
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