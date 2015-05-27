//
//  ProjectFileController.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 5/27/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import Foundation
class ProjectModel{
    // signleton
    class var Instance:ProjectModel{
        struct Static{
            static let instance : ProjectModel = ProjectModel()
        }
        return Static.instance;
    }
    init(){
        self.currentProject = NSDictionary.new();
    }
    var currentProject: NSDictionary;
    // constant data
    private struct const{
        static var projectFileName:String = "DefaultProject"
        static var projectFileType:String = "plist"
        static var applicationName:String = "GitRebaseFlower"
    }
    
    enum ProjectFileMember {
        case ProjectName
        case OwnerName
        case GitPath
        case WorkspacePath
        
        func ToString() -> String{
            switch(self){
            case .ProjectName: return "ProjectName"
            case .OwnerName: return "OwnerName"
            case .GitPath: return "GitPath"
            case .WorkspacePath: return "WorkspacePath"
            }
        }
        
    }
    
    private func GetDefaultProject() -> NSDictionary! {
        if let path = NSBundle.mainBundle().pathForResource( const.projectFileName , ofType: const.projectFileType ){
            println( "default file in there :" + path )
            let defaultFile = NSDictionary( contentsOfFile: path )
            return defaultFile;
        }
        var d = NSDictionary.new()
        return d
    }
    func CreateNewProjectFile( _projectName : String ) -> Bool{

        self.CreateApplicationDataStoreDirectory()
        
        if let defaultFile = self.GetDefaultProject() {
            let dir = self.GetApplicationDataStoreDirectory()
            if( dir == "" ){
                println("dir could not created")
                return false;
            }
            
            self.currentProject = defaultFile;
            self.currentProject.setValue( _projectName, forKey: "ProjectName" );

            let projectFilePath = dir.stringByAppendingPathComponent( _projectName )
            if let projectFilePathAndExtention = projectFilePath.stringByAppendingPathExtension( const.projectFileType ){
                println("new project")
                println(projectFilePathAndExtention)
                defaultFile.writeToFile( projectFilePathAndExtention, atomically: false )
                
                return true;
            }
        }
        
        return false;
    }
 
    func GetApplicationDataStoreDirectory() -> String{
       if let saveTargetPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]{
            let dir = saveTargetPaths[0].stringByAppendingPathComponent( const.applicationName );
            return dir
        }
        return String("")
    }
    
    func CreateApplicationDataStoreDirectory() -> Bool{
        
        let fileManager = NSFileManager.defaultManager()
        let dir = self.GetApplicationDataStoreDirectory()
        if fileManager.fileExistsAtPath( dir ){
            return true
        }else
        if dir != "" {

            var err: NSErrorPointer = nil
            if fileManager.createDirectoryAtPath( dir , withIntermediateDirectories: false, attributes: nil, error: err ) {
                return true;
            }else{
                println( "directory creation error:" + err.debugDescription )
            }
        }
        
        return true;
    }
    
    // 全てのプロジェクトファイルを取得
    func ReqruiteAllProjects() -> [NSDictionary]!{
        let appDir = self.GetApplicationDataStoreDirectory()
        let fileManager = NSFileManager.defaultManager()
        var err: NSErrorPointer = nil
        var array:[NSDictionary] = [NSDictionary]()
        if let files = fileManager.contentsOfDirectoryAtPath( appDir, error: err ){
            for f in files{
                var d = self.LoadProjectFile( f as! String )
                if ( d.objectForKey( ProjectFileMember.ProjectName.ToString() ) != nil ){
                    println( d[ ProjectFileMember.ProjectName.ToString() ] )
                }else{
                    println("d has not contain projectName ");
                    for key in d.keyEnumerator(){
                        println( key )
                    }
                }
                println( "load file done : " + (f as! String) )
                
                array.append( d )
            }
        }
        return array
    }

    func LoadProjectFile( name: String ) -> NSDictionary {
        let appDir = self.GetApplicationDataStoreDirectory()
        let fullPath = appDir.stringByAppendingPathComponent( name )
        if let projectFile = NSDictionary( contentsOfFile: (fullPath as String?)! ) {
            return projectFile;
        }
        var d = NSDictionary.new()
        return d
    }
}