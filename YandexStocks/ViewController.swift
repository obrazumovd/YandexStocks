//
//  ViewController.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import UIKit

class ViewController: UIViewController {
    let networkeManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkeManager.getMarketQuot()
    }


}

