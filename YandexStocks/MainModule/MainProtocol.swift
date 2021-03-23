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
    func showMovieController(navigationController:UINavigationController)

}

protocol PresenterToViewProtocol: class{
    func showStock(stockArray:List<IexStockObject>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> MainViewController
    func pushToStockScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchStock()
}

protocol InteractorToPresenterProtocol: class {
    func stockFetchedSuccess(stockArray:List<IexStockObject>)
    func stockFetchFailed()
}
