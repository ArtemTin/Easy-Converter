//
//  ExchangeRatesGET.swift
//  Easy Converter
//
//  Created by Артём Тихоненко on 04.06.2020.
//  Copyright © 2020 Артём Тихоненко. All rights reserved.
//

import Foundation

func updateRates() -> ([String:Double], [String], String) {
    var res_dict: [String:Double] = [:]
    var res_list: [String] = []
    var update_date = ""
    let file = URL(string: "https://api.exchangeratesapi.io/latest")
    let json = try? Data(contentsOf: file!)
    if let data = json {
        if let json_dec = try? JSON(data: data) {
            update_date = json_dec["date"].stringValue
            for item in json_dec["rates"] {
                res_list.append(item.0)
                res_dict[item.0] = Double(item.1.stringValue)
            }
        }
    }
    res_dict["EUR"] = 1
    res_list.append("EUR")
    return (res_dict, res_list, update_date)
}


