//
//  UsersVC.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/13/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit

class UsersVC: BaseUsersVC {

    var page: Float = 1
    let result = 15
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Users"
    }
    
    private func getModel() {
        page = Float(model.count / result)
        if model.count % result != 0 {
            return
        }
        page += 1
        
        NetworkManager.getUsers(page: Int(page), result: result, onReceive: { [weak self] (response, error) in
            guard let usersModel = response?.results else { return }
            guard let strongSelf = self else { return }
            strongSelf.model.append(contentsOf: usersModel)
            strongSelf.tableView.tableFooterView?.isHidden = true
            strongSelf.tableView.reloadData()
        })
    }
}

//MARK: - UITableViewDelegate
extension UsersVC {
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == tableView.numberOfRows(inSection: tableView.numberOfSections - 1) - 1 {
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator.startAnimating()
            activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableView.tableFooterView = activityIndicator
            self.tableView.tableFooterView?.isHidden = false
        }
        
        if indexPath.row == (result * Int(page)) - 5 {
            getModel()
        }
    }
}


