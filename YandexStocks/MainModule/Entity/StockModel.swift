//
//  StockModel.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation


struct StockModel : Decodable {
    let regularMarketChange,
        regularMarketChangePercent,
        regularMarketPreviousClose,
        regularMarketPrice: Double
    let shortName,
        longName,
        symbol: String
}
