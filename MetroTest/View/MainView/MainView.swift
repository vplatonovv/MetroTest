//
//  MainView.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit
import SDWebImage

class MainView: UIView {
    
    weak var delegate: TwitterViewDelegateProtocol?
    
    struct ViewState {
        
        enum Props {
            case loading
            case loaded([Posts])
            case error(Error)
            
            struct Posts {
                let post: Post
                let onSelect: () -> ()
            }
            
            struct Error {
                let action: () -> ()?
            }
        }
    }
    
    var state: ViewState.Props = .loading {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsLayout()
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "mainViewColor")
        tableView.separatorStyle = .none
        tableView.register(StaticTableViewCell.nibName, forCellReuseIdentifier: StaticTableViewCell.identifier)
        tableView.register(DynamicTableViewCell.nibName, forCellReuseIdentifier: DynamicTableViewCell.identifier)
        return tableView
    }()
    
    private var loadingView = LoadingView(frame: .zero)
    
    private var errorView = ErrorView(frame: .zero)
    
    init(frame: CGRect, delegate: TwitterViewDelegateProtocol) {
        self.delegate = delegate
        super.init(frame: frame)
        configureView()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch state {
        case .loading:
            loadingView.isHidden = false
            loadingView.startAnimating()
            tableView.isHidden = true
            errorView.isHidden = true
            print("is loading")
        case .loaded(_):
            loadingView.isHidden = true
            loadingView.stopAnimating()
            errorView.isHidden = true
            print("is loaded")
            tableView.isHidden = false
            tableView.reloadData()
        case .error(let error):
            loadingView.isHidden = true
            tableView.isHidden = true
            errorView.isHidden = false
            errorView.reload = error.action
        }
    }
    
    private func configureView() {
        guard let view = loadViewFromNib(nibName: MainView.identifier) else { return }
        view.backgroundColor = UIColor(named: "mainViewColor")
        
        view.frame = bounds
        addSubview(view)
        
        view.addSubview(tableView)
        view.addSubview(errorView)
        view.addSubview(loadingView)
    }
    
    private func setConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 224),
            
            errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorView.heightAnchor.constraint(equalToConstant: 227)
        ])
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case .loaded(let posts) = state {
            switch section {
            case 0:
                return 1
            case 1:
                return posts.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if case .loaded(let posts) = state {
            switch indexPath.section {
            case 0:
                // static cell here
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StaticTableViewCell", for: indexPath) as? StaticTableViewCell else {
                    return .init()
                }
                return cell
            case 1:
                // dynamic cell here
                let post = posts[indexPath.row].post
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DynamicTableViewCell", for: indexPath) as? DynamicTableViewCell else {
                    return .init()
                }
                cell.configureCell(with: post)
                if let date = delegate?.getConvertDate(from: post.createdAt) {
                    cell.date = date
                }
                if let urlImage = URL(string: post.image ?? "") {
                    cell.postImage.sd_setImage(with: urlImage, completed: nil)
                }
                /*
                 //uncomment to test image
                 if indexPath.row == 3 {
                 cell.image = UIImage(named: "testImage")
                 }
                 if indexPath.row == 7 {
                 cell.image = UIImage(named: "testImage")
                 }
                 */
                return cell
            default:
                return .init()
            }
        }
        return UITableViewCell()
    }
    
    // MARK: TableViewDataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .loaded(let posts) = state {
            let post = posts[indexPath.row]
            post.onSelect()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
