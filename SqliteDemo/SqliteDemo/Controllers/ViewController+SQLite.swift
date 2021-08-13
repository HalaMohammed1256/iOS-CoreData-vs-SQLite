//
//  ViewController+SQLite.swift
//  SqliteDemo
//
//  Created by Hala on 13/08/2021.
//

import UIKit
import SQLite3


// SQLite
extension ViewController{
    
    func showErrorAlert(){
        
        let alert = UIAlertController(title: nil, message: "Please, Enter a valid ID", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(OKAction)

        self.present(alert, animated: true, completion: nil)
        
    }
    
    // OpaquePointer: Swift type for c language pointers
    func openDatabase() -> OpaquePointer?{
        
        var db: OpaquePointer?
        
        // create
        let fileUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Contacts.sqlite")
        
        // open connection to database
        if sqlite3_open(fileUrl?.path, &db) == SQLITE_OK{
            print("Connection opend sucessfully")
            return db
        }else{
            print("Connection not opend")
            return nil
        }
        
    }
    
    
    func createTable(db: OpaquePointer?){
        // SQL select statement
        let createTableString = "CREATE TABLE Contacts(Id INT PRIMARY KEY NOT NULL, Name CHAR(255))"
        
        var createTableStatement: OpaquePointer?
        
        // sqlite3_prepare_v2: convert sql statement to byte code and return status code to check if is ok
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            
            // sqlite3_step: run the compiled statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Contacts table create")
            }else{
                print("Contacts table not created")
            }
            
        }else{
            print("Create table statement not prepared")
        }
        
        // sqlite3_finalize: to delete compiled statement and avoid resource leaks.
        sqlite3_finalize(createTableStatement)
        
    }
    
    
    func insert(id: Int32, name: NSString, db: OpaquePointer?){
        
        // SQL insert statement
        let insertStatementString = "INSERT INTO Contacts(Id, Name) VALUES (?, ?);"
        var insertStatement: OpaquePointer?
        
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            
            // binding an Int to the statement
            // first paramter is statement // second: a non-zero-based index for the position of the ? you’re binding to. // three: the value
            sqlite3_bind_int(insertStatement, 1, id)
            sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("row inserted successfuly")
            }else{
                print("could not insert row")
                
                showErrorAlert()
                
            }
            
        }else{
            print("insert statement could not prepared")
        }
        
        sqlite3_finalize(insertStatement)
        
    }

    
    func selectAllContacts(db: OpaquePointer?){
        
        // SQL selection statement
        let queryStatementString = "SELECT * FROM Contacts"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
            
            contacts.removeAll()
            
            // SQLITE_ROW: retrive a row
            while sqlite3_step(queryStatement) == SQLITE_ROW{
                
                // sqlite3_column_int: read and retrive the values from the returned row. you can access the row’s values column-by-column (zero-based index)
                let id = sqlite3_column_int(queryStatement, 0)
                guard let nameUnsafePointer = sqlite3_column_text(queryStatement, 1) else{
                    return
                }
                let name = String(cString: nameUnsafePointer)

                contacts.append("\(id) | \(name)")
                
            }
            self.contactsTableView.reloadData()
            
        }else{
            let error = String(cString: sqlite3_errmsg(db))
            print("error message: \(error)")
        }
        
        sqlite3_finalize(queryStatement)
        
    }
    
    
    func delete(db: OpaquePointer?, id: Int){
        
        let deleteStatementString = "DELETE FROM Contacts WHERE Id = \(id)"
        var deleteStatement: OpaquePointer?
        
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK{
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("row deleted successfuly")
            }else{
                print("could not deleye row")
            }
            
        }else{
            print("delete statement not prepared")
        }
        
        sqlite3_finalize(deleteStatement)
    }
    
}


