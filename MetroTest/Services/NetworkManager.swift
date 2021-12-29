//
//  NetworkManager.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import SwiftyJSON
import SDWebImage
import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        let urlString = "https://devapp.mosmetro.ru/api/tweets/v1.0/"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            do {
                let json = try JSON(data: data)
                let posts = Post.getAllPostsFromJson(json)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
}
