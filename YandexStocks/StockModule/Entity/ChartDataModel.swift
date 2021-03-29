//
//  ChartData.swift
//  YandexStocks
//
//  Created by Дмитрий on 28.03.2021.
//

import Foundation


struct ChartDataModel: Decodable{
    let close, high, low, open: Double?
    let symbol: String?
    let volume: Int?
    let id, key, subkey, date: String?
    let updated: Int?
    let changeOverTime, marketChangeOverTime, uOpen, uClose: Double?
    let uHigh, uLow: Double?
    let uVolume: Int?
    let fOpen, fClose, fHigh, fLow: Double?
    let fVolume: Int?
    let label: String?
    let change, changePercent: Double?
}
