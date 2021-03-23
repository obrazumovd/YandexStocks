//
//  MainRouter.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import UIKit


class MainRouter:PresenterToRouterProtocol{
    
    
    
    static func createModule() -> MainViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MainPresenter()
        let interactor: PresenterToInteractorProtocol = MainInteractor()
        let router:PresenterToRouterProtocol = MainRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToStockScreen(navigationConroller: UINavigationController) {
        
    }

}
