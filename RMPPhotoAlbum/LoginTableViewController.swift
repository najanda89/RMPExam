//
//  LoginTableViewController.swift
//  StartRealmMobilePlatform
//
//  Created by Lee Jiho on 2017. 4. 2..
//  Copyright © 2017년 Lee Jiho. All rights reserved.
//

import UIKit
import RealmSwift


class LoginTableViewController: UITableViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var userSignIn: User?
    
    private let urlString: String = "http://192.168.0.7:9080"
    var activity: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2 - 64.0)
        activity.color = UIColor.gray
        activity.stopAnimating()
        activity.isHidden = true
        self.view.addSubview(activity)
        
        self.title = "로그인"
        usernameTextField.becomeFirstResponder()

    }
    
    @IBAction func signIn() {
        
        activity.startAnimating()
        activity.isHidden = false
        
        if usernameTextField.isEditing {
            usernameTextField.resignFirstResponder()
        } else if passwordTextField.isEditing {
            passwordTextField.resignFirstResponder()
        }
        
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }

        let url = URL(string: urlString)
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: url!) { (user, error) in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            UserData.shareInstance.identity = user
            
            self.activity.stopAnimating()
            self.activity.isHidden = true
            
            self.activity.removeFromSuperview()
            
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AlbumListView")
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    @IBAction func showSignUp() {
    
        guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") else {
            print("Don't exist SignUp ViewController")
            return
        }
        
        self.present(signUpViewController, animated: true, completion: nil)
        
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
        return 2
    }
}
