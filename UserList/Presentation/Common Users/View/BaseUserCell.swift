//
//  BaseUserCell.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/14/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit
import Kingfisher

class BaseUserCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.corner(radius: userImageView.frame.width / 2)
        }
    }
    
    var model: Users! {
        didSet {
            if let dataImage = model.profileImage {
                userImageView.image = UIImage(data: dataImage)
            } else {
                getImageFrom(url: model.picture?.large ?? "")
            }
            userNameLabel.text = (model.name?.first ?? "").capitalized + " " + (model.name?.last ?? "").capitalized
            userPhoneLabel.text = (model.phone ?? "").formattedNumber
        }
    }
    
    private func getImageFrom(url: String) {
        NetworkManager.downloadImageFrom(url: url) { [weak self] (response, error) in
            guard error == nil else { return }
            guard let image = response else { return }
            guard let strongSelf = self else { return }
            strongSelf.userImageView.image = UIImage(data: image)
        }
    }
}
