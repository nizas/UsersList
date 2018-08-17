//
//  EditUserVC.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/16/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit

class EditUserTVC: UITableViewController {

    //MARK: IBOutlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.corner(radius: profileImageView.frame.width / 2)
        }
    }
    
    var model: Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        guard let model = self.model else { return }
        
        navigationItem.title = "Edit user profile"
        navigationController?.navigationBar.topItem?.title = ""
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton(_:)))
        navigationItem.setRightBarButton(saveButton, animated: false)

        tableView.tableFooterView = UIView()
        
        phoneTextField.inputAccessoryView = defaultKeyboardToolbar()
        firstNameTextField.text = model.name?.first?.capitalized
        lastNameTextField.text = model.name?.last?.capitalized
        emailTextField.text = model.email
        phoneTextField.text = model.phone?.formattedNumber
        if let imageData = model.profileImage {
            profileImageView.image = UIImage(data: imageData)
        } else {
            NetworkManager.downloadImageFrom(url: model.picture?.large ?? "") { [weak self] (data, error) in
                guard error == nil else { return }
                guard let imageData = data else { return }
                guard let strongSelf = self else { return }
                strongSelf.profileImageView.image = UIImage(data: imageData)
                strongSelf.model?.profileImage = imageData
            }
        }
        
    }
    
    private func checkTextFields() -> Bool {
        if isValidOnlyWhitespaceIn(string: firstNameTextField.text ?? "") ||
            isValidOnlyWhitespaceIn(string: lastNameTextField.text ?? "") {
            presentMessage(text: "Please enter a valid first and last name", complition: nil)
            return false
        } else if (firstNameTextField.text?.count)! > 30 || (lastNameTextField.text?.count)! > 30 {
            presentMessage(text: "Maximum First Name and Last Name length 30 characters", complition: nil)
            return false
        } else if !isValid(email: emailTextField.text ?? "") {
            presentMessage(text: "Please enter a valid e-mail address", complition: nil)
            return false
        }
        return true
    }
    
    @objc func didTapSaveButton(_ sender: UIBarButtonItem) {
        if checkTextFields() {
            guard let model = self.model else { return }
            guard let image = profileImageView.image else { return }
            let user = Users(value: model)
            if let name = model.name {
                user.name = Name(value: name)
            }
            user.profileImage = UIImagePNGRepresentation(image)
            user.email = emailTextField.text
            user.phone = phoneTextField.text
            user.name?.first = firstNameTextField.text
            user.name?.last = lastNameTextField.text
            DatabaseManager.save(user: user) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func didTapChangePhoto(_ sender: UIButton) {
        createImageAlert()
    }
    
    @IBAction func didChangePhoneTextField(_ sender: UITextField) {
        phoneTextField.text = sender.text?.formattedNumber
    }
}

//MARK: - UITextFieldDelegate
extension EditUserTVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(false)
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate
extension EditUserTVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func createImageAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.chooseImagePickerAction(sourse: .camera)
        }
        let photoLibAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.chooseImagePickerAction(sourse: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func chooseImagePickerAction(sourse: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        profileImageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
