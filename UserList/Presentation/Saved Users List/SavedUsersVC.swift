//
//  SavedUsersVC.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/13/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit

class SavedUsersVC: BaseUsersVC {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Saved"
        model = DatabaseManager.getUsers()
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}

extension SavedUsersVC {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            DatabaseManager.delete(user: model[indexPath.row]) {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.model = DatabaseManager.getUsers()
                tableView.endUpdates()
            }
        }
    }
}

