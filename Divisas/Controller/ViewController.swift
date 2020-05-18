//
//  ViewController.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 17/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, ExchangeRatesDelegate {
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var originCurrency: UITextField!
    @IBOutlet weak var targetCurrency: UITextField!
    @IBOutlet weak var labelOriginCurrency: UILabel!
    @IBOutlet weak var labelTargetCurrency: UILabel!
    
    private var picker = UIPickerView()
    private var exchangeRatesManager = ExchangeRatesManager()
    private var rates: Array<Rate> = Array()
    private var originRate: Rate!
    private var targetRate: Rate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOriginCurrency.text = ""
        labelOriginCurrency.text = ""
        originCurrency.isEnabled = false
        targetCurrency.isEnabled = false
        originCurrency.delegate = self
        targetCurrency.delegate = self
        amount.delegate = self
        exchangeRatesManager.delegate = self
        exchangeRatesManager.fecthExchangeRates()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OnViewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func OnViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // determine how many columns we want in our picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rates[row].code
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0) {
            originCurrency.text = rates[row].code
            originRate = Rate(taxRate: rates[row].taxRate, code: rates[row].code)
        } else {
            targetCurrency.text = rates[row].code
            targetRate = Rate(taxRate: rates[row].taxRate, code: rates[row].code)
        }
        
        if let amount = amount.text {
            convertRates(amount: Double(amount)!, originRate: originRate, targetRate: targetRate)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.accessibilityLabel! == "originCurrency") {
            picker.tag = 0
        } else if textField.accessibilityLabel! == "targetCurrency"{
            picker.tag = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.accessibilityLabel == "amount" {
            if let amount = amount.text {
                convertRates(amount: Double(amount)!, originRate: originRate, targetRate: targetRate)
            }
        }
    }
    
    func didUpdateExchangeRates(_ rates: Array<Rate>) {
        DispatchQueue.main.async {
            self.originCurrency.isEnabled = true
            self.targetCurrency.isEnabled = true
            self.picker.dataSource = self
            self.picker.delegate = self
            self.originCurrency.inputView = self.picker
            self.targetCurrency.inputView = self.picker
            self.rates = rates
            self.setInitRates(rates)
        }
    }
    
    func didFaildWithError(_ error: Error) {
        labelOriginCurrency.text = "Something went wrong"
        labelOriginCurrency.text = ""
    }
    
    func convertRates(amount: Double, originRate: Rate, targetRate: Rate) {
        if amount > 0 && originRate.taxRate > 0 && targetRate.taxRate > 0 {
            let result = (amount / originRate.taxRate) * targetRate.taxRate;
            labelOriginCurrency.text = "\(amount) (\(originRate.code)) ="
            labelTargetCurrency.text = "\(String.init(format: "%.5f", result)) (\(targetRate.code))"
        }
    }
    
    func setInitRates(_ rates: Array<Rate>) {
        amount.text = "1"
        
        if let rate = rates.first(where: { $0.code == "COP"}) {
            originCurrency.text = rate.code
            originRate = Rate(taxRate: rate.taxRate, code: rate.code)
        }
        
        if let rate = rates.first(where: { $0.code == "USD"}) {
            targetCurrency.text = rate.code
            targetRate = Rate(taxRate: rate.taxRate, code: rate.code)
        }
        
        if let amount = amount.text {
            convertRates(amount: Double(amount)!, originRate: originRate, targetRate: targetRate)
        }
    }
}

