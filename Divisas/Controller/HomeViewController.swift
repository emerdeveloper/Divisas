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
            self.performSegue(withIdentifier: "goToDivisas", sender: self)
       } else {
            self.performSegue(withIdentifier: "goToByteCoin", sender: self)
        }
    }
        
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToDivisas" {
//
//        } else if segue.identifier == "goToByteCoin" {
//
//        }
//    }

    
    /*
     // MARK: - Replace Root windows
     
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
     
     */
}
