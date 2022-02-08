//
//  Post.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import Foundation
import SwiftyJSON

struct Post {
    
    let text: String
    let createdAt: Date
    let retweetCount: Int
    let favoriteCount: Int
    let image: String?
    
    static func getAllPostsFromJson(_ json: JSON) -> [Post] {
        var posts: [Post] = []
        json["data"].forEach { _, json in
            let post = Post(with: json)
            posts.append(post)
        }
        return posts
    }
    
    init(with json: JSON) {
        let text = json["text"].stringValue
        let createdAt = Date(milliseconds: json["createdAt"].intValue)
        let retweetCount = json["retweetCount"].intValue
        let favoriteCount = json["favoriteCount"].intValue
        
        self.text = text
        self.createdAt = createdAt
        self.retweetCount = retweetCount
        self.favoriteCount = favoriteCount
        if let image = json["mediaEntities"][0].string {
            self.image = image
        } else {
            image = nil
        }
    }
}
