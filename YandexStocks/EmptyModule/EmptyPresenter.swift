//
//  EmptyPresenter.swift
//  YandexStocks
//
//  Created by Дмитрий on 25.03.2021.
//

import Foundation
import RealmSwift


class EmptyPresenter: EmptyViewToPresenterProtocol{
    var delegate: EmptyViewToParent?
    var view: EmptyPresenterToViewProtocol?
    var interactor: EmptyPresenterToInteractorProtocol?
    
    
    func startFetchingPopulary() {
        interactor?.fetchPopulary()
    }
    
    func startFetchingHistory() {
        interactor?.fetchHistory()
    }
}

extension EmptyPresenter : EmptyInteractorToPresenterProtocol{
    func popularyFetchingSuccess(popularyArray: [String]) {
        view?.showPopulary(popularyArray: popularyArray)
    }
    
    func historyFeatchingSuccess(historyArray: List<HistoryObject>) {
        view?.showHistory(historyArray: historyArray)
    }
    
    func popularyFetchingError(error: String) {
        view?.popularyFetchFailed(error: error)
    }
  
}
