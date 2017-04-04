//
//  User.swift
//  StartRealmMobilePlatform
//
//  Created by Lee Jiho on 2017. 4. 2..
//  Copyright © 2017년 Lee Jiho. All rights reserved.
//

import UIKit
import RealmSwift

class User: NSObject {
    
    private var username: String = ""
    private var password: String = ""
    private let urlString: String = "http://192.168.0.7:9080"
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func signUser(register: Bool) {

        let url = URL(string: urlString)
        SyncUser.logIn(with: .usernamePassword(username: self.username, password: password, register: register), server: url!) { (user, error) in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            UserDefaults.standard.set(user, forKey: "SyncUser")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "syncUser"), object: nil, userInfo: nil)
            
        }

    }
}

class UserData: NSObject {
    static let shareInstance = UserData()
    
    var identity: SyncUser? = nil
}
