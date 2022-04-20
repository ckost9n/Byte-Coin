//
//  CoinManager.swift
//  Byte Coin
//
//  Created by Konstantin on 20.04.2022.
//

import UIKit

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "?apikey=E8E45E3B-8314-4B88-B029-4EF3B1C92764"
    
    let currencyArray = ["AUD", "RUB", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = baseURL + currency + apiKey
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
            }
            
            guard let safeData = data else { return }
            guard let coin = parseJSON(safeData) else { return }
            
            delegate?.didUpdateCoin(self, coin: coin)
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            
            let cryptocurrency = decodeData.cryptocurrency
            let currency = decodeData.currency
            let rate = decodeData.rate
            
            let coin = CoinModel(cryptocurrency: cryptocurrency, currency: currency, rate: rate)
            
            return coin
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}
