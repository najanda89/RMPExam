//
//  RealmDataCenter.swift
//  StartRealmMobilePlatform
//
//  Created by Lee Jiho on 2017. 4. 2..
//  Copyright © 2017년 Lee Jiho. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumList: Object {
    
    dynamic var albumName: String?
    dynamic var createDate: Date = Date()
    
    let photo: List<Photos> = List<Photos>()
    
}

class Photos: Object {
    
    dynamic var photo: Data = Data()
    dynamic var createDate: Date = Date()
    
}
