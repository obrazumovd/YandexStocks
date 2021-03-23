//
//  RealmRepository.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import  RealmSwift

class  RealmRepository {
    func addStockObject(stockModels : [StockModel]){
        let arrayStock = List<StockObject>()
        for stockModel in stockModels{
            arrayStock.append(StockObject(stockModel: stockModel))
        }
        
        let realm = try! Realm()
        try! realm.safeWrite{
            realm.add(arrayStock, update: .modified)
        }
    }
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
                try block()
        } else {
            try write(block)
        }
    }
}

extension Results {
  var list: List<Element> {
    reduce(.init()) { list, element in
      list.append(element)
      return list
    }
  }
}


