//
//  sendSuccessful.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 11/5/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.


import UIKit

class sendSuccessfully: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toOrders(){
        let storyboard = UIStoryboard(name: "myOrders", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "myOrders")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = linkingVC
    }
}
