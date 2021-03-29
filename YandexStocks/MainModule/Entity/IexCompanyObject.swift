//
//  IexCompanyObject.swift
//  YandexStocks
//
//  Created by Дмитрий on 27.03.2021.
//

import Foundation
import RealmSwift

class IexCompanyObject : Object{
    @objc dynamic var symbol = ""
    @objc dynamic var companyName = ""
    @objc dynamic var exchange = ""
    @objc dynamic var industry = ""
    @objc dynamic var website = ""
    @objc dynamic var odDescription = ""
    @objc dynamic var ceo = ""
    @objc dynamic var securityName = ""
    @objc dynamic var issueType = ""
    @objc dynamic var sector = ""
    @objc dynamic var address = ""
    @objc dynamic var address2 = ""
    @objc dynamic var state = ""
    @objc dynamic var city = ""
    @objc dynamic var zip = ""
    @objc dynamic var country = ""
    @objc dynamic var phone = ""
    @objc dynamic var primarySicCode = 0
    
    override static func primaryKey() -> String? {
          return "symbol"
       }
    
    convenience init (iexCompanyModel : IexCompanyModel){
        self.init()
        self.symbol = iexCompanyModel.symbol ?? ""
        self.companyName = iexCompanyModel.companyName ?? ""
        self.exchange = iexCompanyModel.exchange ?? ""
        self.industry = iexCompanyModel.industry ?? ""
//        self.website = iexCompanyModel.website ?? ""
//        self.odDescription = iexCompanyModel.description ?? ""
//        self.ceo = iexCompanyModel.CEO ?? ""
//        self.securityName = iexCompanyModel.securityName ?? ""
//        self.issueType = iexCompanyModel.issueType ?? ""
//        self.sector = iexCompanyModel.sector ?? ""
//        self.address = iexCompanyModel.address ?? ""
//        self.address2 = iexCompanyModel.address2 ?? ""
//        self.state = iexCompanyModel.state ?? ""
//        self.city = iexCompanyModel.city ?? ""
//        self.zip = iexCompanyModel.zip ?? ""
//        self.country = iexCompanyModel.country ?? ""
//        self.phone = iexCompanyModel.phone ?? ""
//        self.primarySicCode = 0
    }
}

