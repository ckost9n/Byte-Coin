//
//  CoinModel.swift
//  Byte Coin
//
//  Created by Konstantin on 20.04.2022.
//

import Foundation

struct CoinModel {
    
    let cryptocurrency: String
    let currency: String
    let rate: Double

    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
