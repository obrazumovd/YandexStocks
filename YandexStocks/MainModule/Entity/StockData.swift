//
//  StockData.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import RealmSwift

protocol StockDataDelegate : class{
    func fetchStockData()
}


class StockData {
    private var stockToken: NotificationToken?
    private var stockResult : Results<IexStockObject>
    
    var stocks = List<IexStockObject>()
    weak var delegate : StockDataDelegate?
    
    init(){
        let realm = try! Realm()
        stockResult = realm.objects(IexStockObject.self)
        self.stocks = self.stockResult.list
        activateStockToken()
    }
    
    private func activateStockToken(){
        stockToken = stockResult.observe{[weak self] change in
            guard let list = self?.stockResult.list else {return}
            self?.stocks = list
            self?.delegate?.fetchStockData()
        }
    }
    
    deinit {
        print("DEBAG: deinit")
    }
    
}
