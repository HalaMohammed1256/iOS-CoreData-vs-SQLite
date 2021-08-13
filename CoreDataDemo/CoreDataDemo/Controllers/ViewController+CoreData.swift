//
//  ViewController+CoreData.swift
//  CoreDataDemo
//
//  Created by Hala on 13/08/2021.
//

import UIKit
import CoreData


extension ViewController{
    
    func save(id: Int, name: String){
        
        let newContact = Contacts(context: self.context!)
        newContact.id = Int32(id)
        newContact.name = name
        
        do{
            try context?.save()
            print("Data added successfully")
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        delegate?.saveContext()
        
    }
    
    func removeContact(index: Int){
        
        context?.delete((contacts?[index])!)
        
        do{
            try context?.save()
            contactsTableView.reloadData()
            print("Data removed successfully")
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        delegate?.saveContext()
        
    }
    
    func FetchData(){
        
        let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        
        do{
            contacts = try context?.fetch(request)
            contactsTableView.reloadData()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        delegate?.saveContext()
        
    }
}
