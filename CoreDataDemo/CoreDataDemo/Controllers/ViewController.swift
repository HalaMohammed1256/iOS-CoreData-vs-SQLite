//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Hala on 13/08/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    var contacts: [Contacts]?
    
    
    var delegate: AppDelegate?
    var context: NSManagedObjectContext?
    
    
    @IBOutlet weak var contactsTableView: UITableView!{
        didSet{
            contactsTableView.delegate = self
            contactsTableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = UIApplication.shared.delegate as? AppDelegate
        context = delegate?.persistentContainer.viewContext
        
        FetchData()
        
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
            if let contactID = alert?.textFields?[0].text, let name = alert?.textFields?[1].text, let id = Int(contactID) {
                
                save(id: id, name: name)
                FetchData()
                
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

