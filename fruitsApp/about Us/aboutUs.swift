//
//  aboutUs.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/29/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
class aboutUs: common{
    @IBOutlet var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getConfig{
            data in
            self.content.text = data?.aboutUs ?? ""
        }
        setupBackButtonWithDismiss()        
    }
}

