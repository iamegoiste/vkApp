//
//  MainUserPage.swift
//  vkApp
//
//  Created by Arthur Oganesian on 05.07.2020.
//  Copyright © 2020 Arthur Oganesian. All rights reserved.
//

import UIKit

class MainUserPage: UIViewController {
    @IBOutlet weak var centerText: UILabel!
    var name: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        centerText.text = name
    }
    
    @IBAction func addWord(_ sender: UIBarButtonItem) {
        centerText.text = (centerText.text ?? "") + " hello"
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func unwindAction(_ sender: UIStoryboardSegue) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    @IBAction func startScreenSegue(_ sender: Any) {
    }
    
}
