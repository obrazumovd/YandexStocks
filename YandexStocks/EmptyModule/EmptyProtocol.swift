//
//  EmptyProtocol.swift
//  YandexStocks
//
//  Created by Дмитрий on 25.03.2021.
//

import Foundation
import RealmSwift

protocol EmptyViewToPresenterProtocol: class {
    var view: EmptyPresenterToViewProtocol? {get set}
    var interactor: EmptyPresenterToInteractorProtocol? {get set}
    
    func startFetchingPopulary()
    func startFetchingHistory()
    
}

protocol EmptyPresenterToViewProtocol: class{
    func showPopulary(popularyArray: [String])
    func showHistory(historyArray: List<HistoryObject>)
    func popularyFetchFailed(error: String)
}

protocol EmptyPresenterToRouterProtocol: class {
    static func createModule()-> EmptyView
}

protocol EmptyPresenterToInteractorProtocol: class{
    var presenter: EmptyInteractorToPresenterProtocol? {get set}
    func fetchPopulary()
    func fetchHistory()
}

protocol EmptyInteractorToPresenterProtocol: class{
    func popularyFetchingSuccess(popularyArray: [String])
    func historyFeatchingSuccess(historyArray: List<HistoryObject>)
    func popularyFetchingError(error: String)
}

protocol EmptyViewToParent: class{
    func didSelectSymbol(symbol: String)
}
