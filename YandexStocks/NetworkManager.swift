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

class NetworkManager {
    
    let headers: HTTPHeaders = [
        "X-Mboum-Secret" : "demo"
    ]
    
    let apiRoot = "https://mboum.com/api/v1"
   
    
    
    
    let apiIexcloud = "https://sandbox.iexapis.com"
    let tokenIexcloud = "Tpk_a2e65711c5d647e18fb4aecab2e586a6"

    
    func getTrending(){
        
        let url = apiRoot + UrlMoboum.trending
        
        AF.request(url, method: .get, headers: headers){ $0.timeoutInterval = 10 }.responseData{ [weak self] response in
            guard let data = response.data else {return}
            do{
                let trending = try JSONDecoder().decode([TrendingModel].self, from: data)
//                print(trending)
                guard let quotes = trending.first?.quotes else{return}
                self?.getQuot(quotes: quotes)
                                
            } catch let error{
                print("Error serelization meUpdate", error)
            }
        }
    }
//    alphavantage 7VSUTKLHR5929E40
    func getQuot(quotes: [String]){
//        let reqLimit = 100
//        let url = apiIexcloud + UrlIexapis.quote
//        for reqArray in quotes.chunked(into: reqLimit){
//            let quotesString = reqArray.joined(separator: ",")
//            let param = ["symbol" : quotesString]
//            let url = "https://financialmodelingprep.com/api/v3/quote/\(quotesString)?apikey=19856e2bd96f42595a86ccedb5fa1f3a"
            let url = "https://sandbox.iexapis.com/stable/stock/market/previous/?token=Tpk_a2e65711c5d647e18fb4aecab2e586a6"
            AF.request(url, method: .get){ $0.timeoutInterval = 10 }.responseData{ response in
                guard let data = response.data else {return}
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // try to read out a string array
//                        print(json)
                    }
//                    let stock = try JSONDecoder().decode(StockModel.self, from: data)
//                    print(stock)
                                    
                } catch let error{
                    print("Error serelization meUpdate", error)
                }
//            }
//            break
        }
    }
        
        func getMarketQuot(){
            let url = "https://sandbox.iexapis.com/stable/stock/market/previous/?token=Tpk_a2e65711c5d647e18fb4aecab2e586a6"
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
                    print("Error serelization meUpdate", error)
                }
        }
    }
    
    func getLogo(symbol: String, completion: @escaping(UIImage?)->()){
//        let url = "https://sandbox.iexapis.com/stable/stock/\(symbol)/logo/?token=Tpk_a2e65711c5d647e18fb4aecab2e586a6"
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





