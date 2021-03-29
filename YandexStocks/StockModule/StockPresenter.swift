//
//  StockPresenter.swift
//  YandexStocks
//
//  Created by Дмитрий on 28.03.2021.
//

import Foundation
import Charts


class StockPresenter: StockViewToPresenterProtocol {
    
    
    var view: StockPresenterToViewProtocol?
    
    var interactor: StockPresenterToInteractorProtocol?
    
    var router: StockPresenterToRouterProtocol?
    
    func startFetchQuote(period: ChartPeriod) {
        interactor?.fetchQuote(period: period)
    }
    func fetchStock() {
        interactor?.fetchStock()
    }
}



extension StockPresenter: StockInteractorToPresenterProtocol{
    func quoteFetchSuccess(data: [ChartDataEntry]) {
        view?.updateChartView(data: data)
    }
    func stockFetchSuccess(iexStockObject: IexStockObject) {
        view?.fetchStockSuccess(iexStockObject: iexStockObject)
    }
}
