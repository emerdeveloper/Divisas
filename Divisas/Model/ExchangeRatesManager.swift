//
//  ExchangeRatesManager.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 17/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import Foundation

protocol ExchangeRatesDelegate {
    func didUpdateExchangeRates(_ rates: Array<Rate>)
    func didFaildWithError(_ error: Error)
}


struct ExchangeRatesManager {
    
    private let exchangeRatesURL = "https://openexchangerates.org//api/latest.json?app_id=8e58388d8f014422a049fef2fab8a61a"
    var delegate: ExchangeRatesDelegate?
    
    func fecthExchangeRates() {
        if let url = URL(string: exchangeRatesURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: OnResponse)
            task.resume()
        }
    }
    
    func OnResponse(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let dataResponse = data {
            if let rates = self.parseJson(exchangeRatesData: dataResponse){
                self.delegate?.didUpdateExchangeRates(rates)
            }
        }
        
    }
    
    private func parseJson(exchangeRatesData: Data) -> Array<Rate>? {
        do {
            let decodedData = try JSONDecoder().decode(ExchangeRates.self, from: exchangeRatesData)
            let ratesList = getRatesCount(exchangeRates: decodedData)
            return ratesList
        } catch {
            self.delegate?.didFaildWithError(error)
            print(error)
            return nil
        }
    }
    
    func getRatesCount(exchangeRates: ExchangeRates) -> Array<Rate> {
        let mirror = Mirror(reflecting: exchangeRates.rates)
        var ratesList: Array<Rate> = Array()
        
        for case let (label?, value) in mirror.children {
            ratesList.append(Rate(taxRate: value as! Double, code: label))
        }
        
        return ratesList
    }
}
