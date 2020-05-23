//
//  BitCoinViewController.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 18/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController {

    @IBOutlet weak var labelBitCoin: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    var coinManager = ByteCoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerCurrency.dataSource = self
        pickerCurrency.delegate = self
        coinManager.delegate = self
        
        coinManager.getCoinPrice(for: labelCurrency.text!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UIPickerViewDelegate and UIPickerViewDataSource

extension ByteCoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}


//MARK: - ByteCoinManagerDelegate

extension ByteCoinViewController: ByteCoinManagerDelegate {
    
    func didUpdateByteCoin(_ byteCoinRate: ByteCoinRate) {
        DispatchQueue.main.async {
            self.labelCurrency.text = byteCoinRate.asset_id_quote
            self.labelBitCoin.text = String.init(format: "%.2f", byteCoinRate.rate)
        }
    }
    
    func didFaildWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.labelCurrency.text = "Error"
            self.labelBitCoin.text = "..."
        }
    }
}
