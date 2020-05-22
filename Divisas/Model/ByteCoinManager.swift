//
//  CoinManager.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 18/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import Foundation

struct ByteCoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "?apikey=346105E3-2E9C-455D-B49E-5721EE19FE72"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)\(apiKey)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> ByteCoinRate? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ByteCoinRate.self, from: data)
            print(decodedData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
