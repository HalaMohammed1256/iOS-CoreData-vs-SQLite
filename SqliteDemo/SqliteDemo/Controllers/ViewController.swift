//
//  ViewController.swift
//  SqliteDemo
//
//  Created by Hala on 13/08/2021.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    var db: OpaquePointer?
    var contacts = [String]()
    
    @IBOutlet weak var contactsTableView: UITableView!{
        didSet{
            contactsTableView.delegate = self
            contactsTableView.dataSource = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = openDatabase()
        createTable(db: db)
        selectAllContacts(db: db)
        
    }
    
    
    
    func showAlert(){
        
        let alert = UIAlertController(title: nil, message: "Enter contact", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter ID"
        }
        alert.addTextField { textField in
            textField.placeholder = "Enter Name"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [self, weak alert] action in
            if let id = alert?.textFields?[0].text, let name = alert?.textFields?[1].text, let contactID = Int32(id), let contactName: NSString = name as? NSString {
                
                insert(id: contactID, name: contactName, db: db)
                selectAllContacts(db: db)
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func AddContactTapped(_ sender: Any) {
        showAlert()
    }
    

}


