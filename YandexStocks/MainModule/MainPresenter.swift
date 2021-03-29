//
//  MainPresenter.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import UIKit
import RealmSwift

class MainPresenter : ViewToPresenterProtocol{

    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingStock() {
        interactor?.fetchStock()
    }
    
    func showStockView(navigationController: UINavigationController, symbol: String) {
        router?.pushToStockScreen(navigationConroller: navigationController, symbol: symbol)
    }
    func saveSymbolToHistory(symbol: String) {
        interactor?.saveSymbolToHistory(symbol: symbol)
    }
    

}

extension MainPresenter: InteractorToPresenterProtocol{
    
    func stockFetchedSuccess(stockArray: List<IexStockObject>) {
        view?.showStock(stockArray: stockArray)
    }
    
    func stockFetchFailed() {
        view?.showError()
    }
}
