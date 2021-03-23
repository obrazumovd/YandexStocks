//
//  MainInteractor.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import RealmSwift


class MainInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    var stockData : StockData
    
    init(){
        
        stockData = StockData()
        stockData.delegate = self
    }
    
    func fetchStock() {
//        NetworkManager().getMarketQuot()
        presenter?.stockFetchedSuccess(stockArray: stockData.stocks)
    }

}

extension MainInteractor : StockDataDelegate{
    func fetchStockData() {
        presenter?.stockFetchedSuccess(stockArray: stockData.stocks)
    }
    
    
}
