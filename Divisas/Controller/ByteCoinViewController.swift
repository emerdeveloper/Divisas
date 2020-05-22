//
//  BitCoinViewController.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 18/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var labelBitCoin: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    let coinManager = ByteCoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerCurrency.dataSource = self
        pickerCurrency.delegate = self
    }
    
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
        //labelCurrency.text = coinManager.currencyArray[row]
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
