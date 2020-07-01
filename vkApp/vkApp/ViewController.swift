//
//  ViewController.swift
//  vkApp
//
//  Created by Arthur Oganesian on 01.07.2020.
//  Copyright © 2020 Arthur Oganesian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
       @IBOutlet weak var passwordField: UITextField!
       @IBOutlet weak var loginField: UITextField!
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
           
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
           scrollView.addGestureRecognizer(tapGesture)
       }
       
       @objc func keyboardWillShown(notification: Notification) {
           let info = notification.userInfo! as NSDictionary
           let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
           
           let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
           
           scrollView.contentInset = contentInsets
           scrollView.scrollIndicatorInsets = contentInsets
       }
       
       @objc func keyboardWillHide(notification: Notification) {
           scrollView.contentInset = UIEdgeInsets.zero
           scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
       }
       
       @objc func hideKeyboard() {
           scrollView.endEditing(true)
       }
       
       @IBAction func enter (_ sender: UIButton) {
           guard let login = loginField.text else { return }
           guard let password = passwordField.text else { return }
           
           if login.isEmpty == true {
            print("Введите логин")
           } else if password.isEmpty == true {
            print("Введите пароль")
           } else if login == "admin", password == "Nimda" {
               print("Вход выполнен!")
           } else if login == "admin", password != "Nimda" {
                print("Неверный пароль")
           } else if login != "admin" {
               print("Пользователь не найден")
           }
    }
}

