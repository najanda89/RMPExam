//
//  AlbumListTableViewController.swift
//  StartRealmMobilePlatform
//
//  Created by Lee Jiho on 2017. 4. 2..
//  Copyright © 2017년 Lee Jiho. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumListTableViewController: UITableViewController {
    
    var albums = List<AlbumList>()
    var realm: Realm!
    var token: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "앨범 리스트"
        
        guard let identity = UserData.shareInstance.identity else { return }
        
        DispatchQueue.main.async {
            
            let configuration = Realm.Configuration(
                syncConfiguration: SyncConfiguration(user: identity, realmURL: URL(string: "realm://192.168.0.7:9080/"+identity.identity!+"/AlbumList")!)
            )
            
            self.realm = try! Realm(configuration: configuration)
            
            self.updateList()
            
            self.token = self.realm.addNotificationBlock({ _ in
                self.updateList()
            })
        }
    }
    
    deinit {
        token.stop()
    }
    
    func updateList() {
        
        self.albums.removeAll()
        if self.albums.realm == nil {
            let lists = self.realm.objects(AlbumList.self)
            for count in 0..<lists.count {
                self.albums.insert(lists[count], at: count)
            }
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func addAlbum() {
        
        var alertTextField:UITextField!
        let alertController = UIAlertController(title: "앨범명", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            alertTextField = textField
        }
        
        let cancelAlert = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let okAlert = UIAlertAction(title: "확인", style: .default) { (okAlert) in

            guard let text = alertTextField.text else { return }
            
            let albumList = AlbumList()
            albumList.albumName = text
            try! self.realm.write {
                self.realm.add(albumList)
            }

        }
        
        alertController.addAction(okAlert)
        alertController.addAction(cancelAlert)
        
        self.present(alertController, animated: true, completion: nil)

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
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        
        if let albumName = albums[indexPath.row].albumName {
            cell.textLabel?.text = albumName
            cell.detailTextLabel?.text = String(describing: albums[indexPath.row].createDate)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
