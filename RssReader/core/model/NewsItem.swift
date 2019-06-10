//
//  NewsItem.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class NewsItem {
    
    private(set) var title: String
    private(set) var description: String
    private(set) var thumbnail: String?

    init(title: String, description: String, thumbnail: String?) {
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
    
    convenience init(item: RssFeed.Item) {
        self.init(title: item.title ?? "", description: item.description ?? "", thumbnail: item.thumbnail)
    }
}
