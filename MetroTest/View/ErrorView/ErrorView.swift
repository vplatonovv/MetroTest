//
//  ErrorView.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

class ErrorView: UIView {
    
    var reload: () -> ()?
    
    override init(frame: CGRect) {
        reload = {}
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        guard let view = loadViewFromNib(nibName: ErrorView.identifier) else { return }
        view.frame = frame
        addSubview(view)
    }
    
    
    @IBAction func reloadButtonTapped() {
        reload()
    }
    
}

