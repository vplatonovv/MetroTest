//
//  TwitterViewController.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

class TwitterViewController: UIViewController {
    
    override func loadView() {
        view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новости"
        updateView(with: .loading)
        fetchPosts()
    }
    
    func fetchPosts() {
        NetworkManager.shared.fetchPosts { [weak self ]result in
            switch result {
            case .success(let posts):
                let post = posts.map { post in
                    MainView.Props.Posts(post: post, onSelect: { print("Go to twitter with \(post)") } )
                }
                self?.updateView(with: .loaded(post))
            case .failure(let error):
                print(error)
                let reload = { [weak self] in
                    self?.fetchPosts()
                    self?.updateView(with: MainView.Props.loading)
                }
                self?.updateView(with: .error(MainView.Props.Error(action: reload)))
            }
        }
    }
    
    private func updateView(with props: MainView.Props) {
        if let customView = self.view as? MainView {
            customView.props = props
        }
    }
    
}
