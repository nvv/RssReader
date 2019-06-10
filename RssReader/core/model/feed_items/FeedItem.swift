//
//  FeedItem.swift
//  RssReader
//
//  Created by Vlad Namashko on 6/1/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class FeedItem {
    let newsItem: NewsItem
    
    let title: String
    let description: String
    let thumbnail: String?
    
    public init(item: NewsItem) {
        newsItem = item
        
        title = item.title
        description = item.description
        thumbnail = item.thumbnail
    }
    
}
