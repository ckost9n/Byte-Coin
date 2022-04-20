//
//  CoinData.swift
//  Byte Coin
//
//  Created by Konstantin on 20.04.2022.
//

import Foundation

struct CoinData: Codable {
    
    let timeString: String
    let cryptocurrency: String
    let currency: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case timeString = "time"
        case cryptocurrency = "asset_id_base"
        case currency = "asset_id_quote"
        case rate
    }
}
