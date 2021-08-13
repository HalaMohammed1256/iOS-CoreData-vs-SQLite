//
//  ViewController+TableViewDelegates.swift
//  CoreDataDemo
//
//  Created by Hala on 13/08/2021.
//

import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = contactsTableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "\(contacts?[indexPath.row].id ?? 0) | \(contacts?[indexPath.row].name ?? "")"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                    
            
                //remove from CoreData
                removeContact(index: indexPath.row)
                
                
                // remove from array
                contacts?.remove(at: indexPath.row)
                
                
                // remove from table
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                contactsTableView.reloadData()
            

                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        
        }
    
}

