//
//  HistoryObject.swift
//  YandexStocks
//
//  Created by Дмитрий on 25.03.2021.
//

import Foundation
import RealmSwift

class HistoryObject: Object {
    @objc dynamic var symbol = ""
    @objc dynamic var date = Date()
    
    convenience init(symbol: String) {
        self.init()
        self.symbol = symbol
    }
    
    override static func primaryKey() -> String? {
          return "symbol"
       }
}
