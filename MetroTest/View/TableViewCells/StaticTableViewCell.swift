//
//  StaticTableViewCell.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

class StaticTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.1
    }
}
