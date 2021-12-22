//
//  TwitterViewController.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

protocol TwitterViewDelegateProtocol: AnyObject {
    func getConvertData(from data: Int) -> String?
    func getImage(from string: String?) -> UIImage?
}

class TwitterViewController: UIViewController {
    
    override func loadView() {
        view = MainView(frame: UIScreen.main.bounds, delegate: self)
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

extension TwitterViewController: TwitterViewDelegateProtocol {
    func getConvertData(from data: Int) -> String? {
        DateManager.shared.convertDate(from: data)
    }
    
    func getImage(from string: String?) -> UIImage? {
        NetworkManager.shared.fetchImage(from: string)
    }
}
