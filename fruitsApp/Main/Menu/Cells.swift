//
//  menuHeaderCell.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/21/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class menuHeaderCell: UITableViewCell {
    @IBOutlet var title: UIButton!
    @IBOutlet var toggle: UIImageView!
}

class menuContentCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var count: UILabel!
}
