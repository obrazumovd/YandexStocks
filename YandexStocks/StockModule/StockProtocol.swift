//
//  StockProtocol.swift
//  YandexStocks
//
//  Created by Дмитрий on 28.03.2021.
//

import Foundation
import UIKit
import Charts
import RealmSwift




protocol StockViewToPresenterProtocol : class{
    var view: StockPresenterToViewProtocol? {get set}
    var interactor: StockPresenterToInteractorProtocol? {get set}
    var router: StockPresenterToRouterProtocol? {get set}
    func startFetchQuote(period: ChartPeriod)
    func fetchStock()
}

protocol StockPresenterToViewProtocol : class{
    func updateChartView(data: [ChartDataEntry])
    func fetchStockSuccess(iexStockObject: IexStockObject)
}

protocol StockPresenterToRouterProtocol : class{
    static func createModule(symbol: String)-> StockView
}

protocol StockPresenterToInteractorProtocol : class {
    var presenter: StockInteractorToPresenterProtocol? {get set}
    var symbol : String? { get set }
    func fetchQuote(period: ChartPeriod)
    func fetchStock()
}

protocol StockInteractorToPresenterProtocol : class{
    func quoteFetchSuccess(data: [ChartDataEntry])
    func stockFetchSuccess(iexStockObject: IexStockObject)
}
