//
//  ViewController+TableViewDelegates.swift
//  SqliteDemo
//
//  Created by Hala on 13/08/2021.
//

import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = contactsTableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        
        cell.textLabel?.text = contacts[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                    
            
                //remove from SQLite
                let stringId = (contacts[indexPath.row].split(separator: " "))[0]
                guard let id = Int(stringId) else {
                    return
                }
                delete(db: db, id: id)
                
                
                // remove from array
                contacts.remove(at: indexPath.row)
                
                
                // remove from table
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                contactsTableView.reloadData()
            

                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        
        }
    
}
