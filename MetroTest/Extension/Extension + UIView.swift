//
//  Extension + UIView.swift
//  MetroTest
//
//  Created by Слава Платонов on 20.12.2021.
//

import UIKit

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
