//
//  AppDelegate.swift
//  IOS-Final-Assignment
//  Prinicpal Author: Sam Whelan
//  Created by  on 3/22/21.
//  Description: Used to create any extra information on load, such as pulling in the users
//  from the db into the app to be displayed
//merger comment
import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //The URL of each dev so that it can display based on who is selected
    var selectedURL: String = ""
    //The name of the db to access
    var databaseName: String? = "AboutUs.db"
    //The path to the db in the phone
    var databasePath: String?
    //The array of devs that will be called in
    var people: [Users] = []
    
    
    //Once the app has launched, this will search for the db in the phone, and create a db if
    //one does not exist
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Used to find the db in the phones directories
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        
        //These methods are here so that once the app is done, it will check to see if it
        //has to make a db, and also read from it once done
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        // Override point for customization after application launch.
        return true
    }
    
    //Will read the data in from the db
    func readDataFromDatabase(){
        
        people.removeAll()
        var db: OpaquePointer? = nil
        
        //Here to try and connect to the db, and then read the data from it
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            
            print("Successfull opened connection to database at \(self.databasePath)")
            
            var queryStatement: OpaquePointer? = nil
            var queryStatementString: String = "select * from entries"
            
            //Here to create the query sequence, and assign the values out once read
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cName = sqlite3_column_text(queryStatement, 1)
                    let cProgram = sqlite3_column_text(queryStatement, 2)
                    let cUrl = sqlite3_column_text(queryStatement, 3)
                    
                    let name = String(cString: cName!)
                    let program = String(cString: cProgram!)
                    let url = String(cString: cUrl!)
                    
                    let data : Users = Users.init()
                    data.initWithData(theRow: id, theName: name, theProgram: program, theUrl: url)
                    people.append(data)
                    
                    print("Query Result")
                    print("\(id) | \(name)")
                    
                    
                }
                
                sqlite3_finalize(queryStatement)
                
            }else{
                print("Select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        }else{
            print("unable to open database")
        }
        
    }
    
    //Checks to see if the db exists, and if not creates is
    func checkAndCreateDatabase(){
        
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        //Here to check and see if the db exists, and if not will create it from the files in
        //Xcode
        if success {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try! fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

