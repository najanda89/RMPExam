//
//  SignUpTableViewController.swift
//  StartRealmMobilePlatform
//
//  Created by Lee Jiho on 2017. 4. 2..
//  Copyright © 2017년 Lee Jiho. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpTableViewController: UITableViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordReTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()

    }
    
    @IBAction func signUp() {
        
    
    }
    
    @IBAction func dismissSignUp() {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

}
