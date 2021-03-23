//
//  IexStockModel.swift
//  YandexStocks
//
//  Created by Дмитрий on 22.03.2021.
//

import Foundation


struct IexStockModel: Decodable {
    let close, high, low, change, changePercent: Double
    let symbol: String
    let updated: Int?
}

