//
//  StockInteractor.swift
//  YandexStocks
//
//  Created by Дмитрий on 28.03.2021.
//

import Foundation
import Charts
import RealmSwift

class StockInteractor: StockPresenterToInteractorProtocol{
    
    
    var presenter: StockInteractorToPresenterProtocol?
    var symbol : String?
    
    func fetchQuote(period: ChartPeriod){
        var lineChartEntry = [ChartDataEntry]()
//        let number : [Double] = [3,4,5,6,5,4,5,6,5,4,7,8,9,8,7,6,5,4,5,6,7,8,7,5,2]
//
//        for i in 0..<number.count{
//            let data = ChartDataEntry(x: Double(i), y: number[i])
//            lineChartEntry.append(data)
//        }
        var periodString = ""
        switch period {
        case .day:
            let today = "20210326"
            periodString = "date/" + today
        case .week:
            periodString = "5dm"
        case .month:
            periodString = "1mm"
        case .halfYear:
            periodString = "6m"
        case .year:
            periodString = "1y"
        case .fiveYear:
            periodString = "5y"
       
        }
        NetworkManager().getChart(symbol: symbol ?? "", period: periodString) {[weak self] (charts) in
            for (index, chart) in charts.enumerated(){
                if let value = chart.close{
                let data = ChartDataEntry(x: Double(chart.updated ?? index), y: value)
                lineChartEntry.append(data)
                }
            }
            self?.presenter?.quoteFetchSuccess(data: lineChartEntry)
        }
        
    }
    func fetchStock() {
        let realm = try! Realm()
        guard let iexStockObject = realm.objects(IexStockObject.self).filter("symbol = %@", symbol ?? "").first else{return}
        presenter?.stockFetchSuccess(iexStockObject: iexStockObject)
    }
}

