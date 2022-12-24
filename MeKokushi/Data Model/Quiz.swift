//
//  Data.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/12/20.
//

import Foundation
import RealmSwift

class Quiz: Object {
    @objc dynamic var tangen = ""
    @objc dynamic var mondai = ""
    @objc dynamic var sentaku1 = ""
    @objc dynamic var sentaku2 = ""
    @objc dynamic var sentaku3 = ""
    @objc dynamic var sentaku4 = ""
    @objc dynamic var sentaku5 = ""
    @objc dynamic var kotae = 0
    
    //@objc dynamic var kotae = 0
}
