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
    
    func showMovieController(navigationController: UINavigationController) {
        router?.pushToStockScreen(navigationConroller: navigationController)
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
