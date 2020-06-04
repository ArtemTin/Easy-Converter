//
//  ExchangeRatesGET.swift
//  Easy Converter
//
//  Created by Артём Тихоненко on 04.06.2020.
//  Copyright © 2020 Артём Тихоненко. All rights reserved.
//

import Foundation

enum Currency: String {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case cad = "CAD"
    case hkd = "HKD"
    case isk = "ISK"
    case php = "PHP"
    case dkk = "DKK"
    case huf = "HUF"
    case czk = "CZK"
    case aud = "AUD"
    case ron = "RON"
    case sek = "SEK"
    case idr = "IDR"
    case inr = "INR"
    case brl = "BRL"
    case hrk = "HRK"
    case jpy = "JPY"
    case thb = "THB"
    case chf = "CHF"
    case sgd = "SGD"
    case pln = "PLN"
    case bgn = "BGN"
    case `try` = "TRY"
    case cny = "CNY"
    case nok = "NOK"
    case nzd = "NZD"
    case zar = "ZAR"
    case mxn = "MXN"
    case ils = "ILS"
    case krw = "KRW"
    case myr = "MYR"
}

extension Currency: Identifiable {
    var id: String { rawValue }
}

class ExchangePair {
    let from_curr: Currency
    
    let to_curr: Currency
    
    let exchangeRate: Double
    
    init(from_curr: Currency, to_curr: Currency, exchangesDict: [Currency: Double]) {
        self.from_curr = from_curr
        self.to_curr = to_curr
        if let from_to_base = exchangesDict[from_curr], let to_to_base = exchangesDict[to_curr] {
            self.exchangeRate = to_to_base / from_to_base
        }
        else {
            self.exchangeRate = 0
        }
        
        
    }
    
    func calc(value: Double) -> Double {
        return self.exchangeRate * value
    }
    
}

func updateDict() -> [Currency:Double] {
    var result: [Currency:Double] = [:]
    let file = URL(string: "https://api.exchangeratesapi.io/latest")
    let json = try? Data(contentsOf: file!)
    if let data = json {
        if let json_dec = try? JSON(data: data) {
            for item in json_dec["rates"] {
                if let nowCurr = Currency(rawValue: item.0) {
                    result[nowCurr] = item.1.doubleValue
                }
            }
        }
    }
    return result
}

func generateList(exchangeDict: [Currency:Double]) -> [Currency] {
    var currencyList: [Currency] = []
    for (key, _) in exchangeDict {
        currencyList.append(key)
    }
    return currencyList
}

var exchangeDict = updateDict()
var currencyList = generateList(exchangeDict: exchangeDict)
