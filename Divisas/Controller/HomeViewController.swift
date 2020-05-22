//
//  HomeViewController.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 21/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectOptionPressed(_ sender: UIButton) {
       if sender.tag == 0 {
//            Safe rootViewController
           if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Divisas") as? ViewController
           {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = vc;
           }
        print("Divisas")
       } else {
//            Safe rootViewController
           if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ByteCoin") as? ByteCoinViewController
           {
               UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = vc;
           }
       }
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
