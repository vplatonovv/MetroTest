//
//  TwitterViewController.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

protocol TwitterViewDelegateProtocol: AnyObject {
    func getConvertDate(from date: Date) -> String?
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
        NetworkManager.shared.fetchPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                let post = posts.map { post in
                    MainView.ViewState.Props.Posts(post: post, onSelect: { print("Go to twitter with \(post)") } )
                }
                self.updateView(with: .loaded(post))
            case .failure(let error):
                print(error)
                let reload = { [self] in
                    self.fetchPosts()
                    self.updateView(with: MainView.ViewState.Props.loading)
                }
                sleep(2)
                self.updateView(with: .error(MainView.ViewState.Props.Error(action: reload)))
            }
        }
    }
    
    private func updateView(with props: MainView.ViewState.Props) {
        DispatchQueue.main.async {
            if let customView = self.view as? MainView {
                customView.state = props
            }
        }
    }
}

extension TwitterViewController: TwitterViewDelegateProtocol {
    func getConvertDate(from date: Date) -> String? {
        DateManager.shared.calculateTime(date: date)
    }
}
