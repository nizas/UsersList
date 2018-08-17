//
//  UIViewController+Extension.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/16/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentMessage(text: String, complition: (() -> Void)?) {
        let alertVC = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            complition?()
        }
        alertVC.view.tintColor = UIColor.black
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
    
    func defaultKeyboardToolbar() -> UIToolbar {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0,  width: UIScreen.main.bounds.width, height: 44.0))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(toolBarDoneButtonAction(_:)))
        doneBtn.tintColor = UIColor.darkText
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    @objc func toolBarDoneButtonAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    func isValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidOnlyWhitespaceIn(string: String) -> Bool {
        if string.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        } else {
            return false
        }
    }
}
