//
//  ViewController.swift
//  vkApp
//
//  Created by Arthur Oganesian on 01.07.2020.
//  Copyright © 2020 Arthur Oganesian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
       @IBOutlet weak var scrollView: UIScrollView!
       @IBOutlet weak var passwordField: UITextField!
       @IBOutlet weak var loginField: UITextField!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login VC Loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Login VC did appear")
    }
    
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
       
    private func checkLoginInfo() -> Bool {
        guard let login = loginField.text else { return false }
        guard let password = passwordField.text else { return false}
        
        if login.isEmpty == true {
            emptyLogin ()
            return false
        } else if password.isEmpty == true {
            emptyPassword()
            return false
        } else if login == "admin", password != "12345" {
            wrongPassword()
            return false
        } else if login == "admin", password == "12345" {
            print("Вход выполнен!")
            return true
        } else {
            print("Вход не выполнен!")
            return false
        }
    }
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           super.prepare(for: segue, sender: sender)
           
           if segue.identifier == "loginSegue" {
               if let destination = segue.destination as? MainUserPage {
                   destination.name = loginField.text
               }
           }
    }
           override func shouldPerformSegue (withIdentifier identifier: String, sender: Any?) -> Bool {
                   
                   if identifier == "loginSegue" {
                       if checkLoginInfo() {
                           return true
                       } else {
                           showLoginError()
                           return false
                       }
                   }
                   
                   return true
               }
    
    private func emptyLogin() {
           let alert = UIAlertController(title: "Please", message: "Enter login", preferredStyle: .alert)
             let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alert.addAction(action)
             
             present(alert, animated: true, completion: nil)
         }
    private func wrongPassword() {
      let alert = UIAlertController(title: "Incorrect password", message: "Try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    private func emptyPassword() {
           let alert = UIAlertController(title: "Please", message: "Enter password", preferredStyle: .alert)
             let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alert.addAction(action)
             
             present(alert, animated: true, completion: nil)
         }
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Error!", message: "Incorrect pair login/password", preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alert.addAction(action)
          
          present(alert, animated: true, completion: nil)
      }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
    }
}
