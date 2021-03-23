//
//  StockObject.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import RealmSwift

@objc class StockObject: Object {
    @objc dynamic var regularMarketChange : Double = 0
    @objc dynamic var regularMarketChangePercent : Double = 0
    @objc dynamic var regularMarketPreviousClose : Double = 0
    @objc dynamic var regularMarketPrice : Double = 0
    @objc dynamic var shortName = ""
    @objc dynamic var longName = ""
    @objc dynamic var symbol = ""
    
    override static func primaryKey() -> String? {
          return "symbol"
       }
    convenience init (stockModel : StockModel){
        self.init()
        self.regularMarketChange = stockModel.regularMarketChange
        self.regularMarketChangePercent = stockModel.regularMarketChangePercent
        self.regularMarketPreviousClose = stockModel.regularMarketPreviousClose
        self.regularMarketPrice = stockModel.regularMarketPrice
        self.shortName = stockModel.shortName
        self.longName = stockModel.longName
        self.symbol = stockModel.symbol
    }
    
    
    
}
