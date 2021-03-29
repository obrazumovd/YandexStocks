//
//  EmptyInteractor.swift
//  YandexStocks
//
//  Created by Дмитрий on 25.03.2021.
//

import Foundation
import RealmSwift


class EmptyInteractor: EmptyPresenterToInteractorProtocol{
    var presenter: EmptyInteractorToPresenterProtocol?
    
    
    func fetchPopulary() {
        NetworkManager().getTrending { [weak self] (symbols, error) in
            if let error = error{
                self?.presenter?.popularyFetchingError(error: error)
                return
            } else{
                self?.presenter?.popularyFetchingSuccess(popularyArray: symbols)
            }
        }
    }
    
    func fetchHistory() {
        let historyObjects = try! Realm().objects(HistoryObject.self).sorted(byKeyPath: "date", ascending: false)
        presenter?.historyFeatchingSuccess(historyArray: historyObjects.list)
    }
}


