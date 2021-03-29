//
//  StockRouter.swift
//  YandexStocks
//
//  Created by Дмитрий on 28.03.2021.
//

import Foundation
import UIKit

class StockRouter : StockPresenterToRouterProtocol{

    static func createModule(symbol: String)-> StockView {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "StockView") as! StockView
        let presenter: StockViewToPresenterProtocol & StockInteractorToPresenterProtocol = StockPresenter()
        
        let interactor: StockPresenterToInteractorProtocol = StockInteractor()
        let router: StockPresenterToRouterProtocol = StockRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.symbol = symbol
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
