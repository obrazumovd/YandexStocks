//
//  IexStockObject.swift
//  YandexStocks
//
//  Created by Дмитрий on 22.03.2021.
//

import Foundation
import RealmSwift


class IexStockObject: Object {
    @objc dynamic var symbol = ""
    @objc dynamic var close : Double = 0
    @objc dynamic var high : Double = 0
    @objc dynamic var low : Double = 0
    @objc dynamic var change : Double = 0
    @objc dynamic var changePercent : Double = 0
    @objc dynamic var updated : Int = 0
    @objc dynamic var isFavorit = false
    
    override static func primaryKey() -> String? {
        return "symbol"
    }
    
    convenience init (iexStockModel : IexStockModel){
        self.init()
        self.symbol = iexStockModel.symbol
        self.close = iexStockModel.close
        self.high = iexStockModel.high
        self.low = iexStockModel.low
        self.change = iexStockModel.change
        self.changePercent = iexStockModel.changePercent
        self.updated = iexStockModel.updated ?? Int(Date().timeIntervalSince1970)
    }
    
}

