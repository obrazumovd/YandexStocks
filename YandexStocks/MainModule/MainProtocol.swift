//
//  MainProtocol.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import UIKit
import RealmSwift


protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingStock()
    func saveSymbolToHistory(symbol: String)
    func showStockView(navigationController:UINavigationController, symbol : String)
}

protocol PresenterToViewProtocol: class{
    func showStock(stockArray:List<IexStockObject>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> MainViewController
    func pushToStockScreen(navigationConroller:UINavigationController, symbol: String)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchStock()
    func saveSymbolToHistory(symbol: String)
}

protocol InteractorToPresenterProtocol: class {
    func stockFetchedSuccess(stockArray:List<IexStockObject>)
    func stockFetchFailed()
}
