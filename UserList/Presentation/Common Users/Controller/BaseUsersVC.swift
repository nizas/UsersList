//
//  ViewController.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/13/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit

class BaseUsersVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "BaseUserCell", bundle: nil), forCellReuseIdentifier: "kBaseUserCell")
        }
    }
    
    var model = [Users]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.showBottomHairline()
    }
}

//MARK: - UITableViewDataSource
extension BaseUsersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
}

//MARK: - UITableViewDelegate
extension BaseUsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kBaseUserCell") as! BaseUserCell
        cell.model = model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ApplicationRouter.showEditUser()
        vc.model = model[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}



