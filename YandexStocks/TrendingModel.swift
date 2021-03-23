//
//  TrendingModel.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation

struct TrendingModel : Decodable {
    let count: Int
    let quotes: [String]
    let jobTimestamp, startInterval: Int
}
