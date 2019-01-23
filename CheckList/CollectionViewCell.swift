//
//  CollectionViewCell.swift
//  CheckList
//
//  Created by Noura Aziz on 1/23/19.
//  Copyright © 2019 Noura Aziz. All rights reserved.
//

import UIKit

// Create protocol to enable button action to access data of ViewController class
protocol CheckBox {
    func checkBox(state: Bool, index: Int?)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkOutlet: UIButton!
    
    var indexP: Int?
    var delegate: CheckBox?
    var days: [Days]?
    
    @IBAction func checkButtonAction(_ sender: Any) {
        if days![indexP!].checked {
            delegate?.checkBox(state: false, index: indexP)
        } else {
            delegate?.checkBox(state: true, index: indexP)
        }
    }
}
