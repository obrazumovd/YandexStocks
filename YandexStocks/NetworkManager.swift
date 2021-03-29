//
//  NetworkManager.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import Alamofire
import RealmSwift

enum UrlMoboum{
    static let trending = "/tr/trending"
    static let quote = "/qu/quote"
}

enum UrlIexapis{
    static let trending = "/tr/trending"
    static let quote = "/qu/quote"
}

enum IexUrl{
    static let previous = "market/previous"
    static let company = "/company"
    static let chart = "/chart/"
}

class NetworkManager {
    
    let headers: HTTPHeaders = [
        "X-Mboum-Secret" : "demo"
    ]
    
    let apiRoot = "https://mboum.com/api/v1"
   
    
    
    
    let apiIexcloud = "https://sandbox.iexapis.com/stable/stock/"
    let tokenIexcloud = "/?token=Tpk_a2e65711c5d647e18fb4aecab2e586a6"
    
    

    
    func getTrending(completion: @escaping(_ quotes: [String], _ error: String?)->()){
        
        let url = apiRoot + UrlMoboum.trending
        
        AF.request(url, method: .get, headers: headers){ $0.timeoutInterval = 10 }.responseData{ response in
            guard let data = response.data else {return}
            do{
                let trending = try JSONDecoder().decode([TrendingModel].self, from: data)
                guard let quotes = trending.first?.quotes else{return}
                completion(quotes, nil)
            } catch let error{
                completion([], error.localizedDescription)
                print("Error serelization meUpdate", error)
            }
        }
    }
        
        func getMarketQuot(){
            let url = apiIexcloud + IexUrl.previous + tokenIexcloud
            AF.request(url, method: .get){ $0.timeoutInterval = 20 }.responseData{ response in
                guard let data = response.data else {return}
                do{
                    let stocks = try JSONDecoder().decode([IexStockModel].self, from: data)
                    DispatchQueue.background(background: {
                        let list = stocks.map{IexStockObject(iexStockModel: $0)}
                        let realm = try! Realm()
                        try! realm.safeWrite {
                            realm.add(list, update: .modified)
                        }
                    }, completion:{
                        print("DEBAG: pars market quot complite")
                    })
                } catch let error{
                    print("Error serelization market quot", error)
                }
        }
    }
    
    func getCompany(symbol: String){
        let url = apiIexcloud + symbol + IexUrl.company + tokenIexcloud
        AF.request(url, method: .get){ $0.timeoutInterval = 20 }.responseData{ response in
            guard let data = response.data else {return}
            do{
                let company = try JSONDecoder().decode(IexCompanyModel.self, from: data)
                
                DispatchQueue.background(background: {
                    let companyObject = IexCompanyObject(iexCompanyModel: company)
                    let realm = try! Realm()
                    guard let iexStockObject = realm.objects(IexStockObject.self).filter("symbol = %@", companyObject.symbol).first else {return}
                    try! realm.safeWrite {
                        realm.add(companyObject, update: .modified)
                        iexStockObject.company = companyObject
                    }
                }, completion:{
                    print("DEBAG: pars company \(symbol) complite")
                })
            } catch let error{
                print("Error serelization company  \(symbol)", error)
            }
    }
    }
    
    func getChart(symbol: String, period: String, completion: @escaping([ChartDataModel])->()){
        let url = apiIexcloud + symbol + IexUrl.chart + period + tokenIexcloud + "&chartCloseOnly=true"
        AF.request(url, method: .get){ $0.timeoutInterval = 20 }.responseData{ response in
            guard let data = response.data else {return}
            do{
                let charts = try JSONDecoder().decode([ChartDataModel].self, from: data)
                completion(charts)               
            } catch let error{
                print("Error serelization company  \(symbol)", error)
            }
    }
    }
    
    
    func getLogo(symbol: String, completion: @escaping(UIImage?)->()){
        let url = "https://storage.googleapis.com/iex/api/logos/\(symbol).png"
        AF.request(url, method: .get){ $0.timeoutInterval = 20 }.responseData{ response in
            guard let data = response.data else{
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
    }
}





