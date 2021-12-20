//
//  LoadinView.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

class LoadinView: UIView {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        guard let view = loadViewFromNib(nibName: "LoadingView") else { return }
        view.frame = frame
        addSubview(view)
    }
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
    
}
