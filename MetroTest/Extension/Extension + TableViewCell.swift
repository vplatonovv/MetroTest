//
//  Extension + TableViewCell.swift
//  MetroTest
//
//  Created by Слава Платонов on 23.12.2021.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
    static var nibName: UINib {
        UINib(nibName: Self.identifier, bundle: nil)
    }
}
