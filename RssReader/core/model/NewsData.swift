//
//  NewsData.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class NewsData {
    
    private var items = [NewsItem]()
    
    init(feedList: [RssFeed]) {
        feedList.forEach { feed in
            feed.items.forEach { item in
                items.append(NewsItem.init(item: item))
            }
        }
        
        shuffle()
    }
    
    private func shuffle() {
        let mixingRatio = 5
        for _ in 0 ..< items.count * mixingRatio {
            let item = items.remove(at: Int(arc4random_uniform(UInt32(items.count))))
            items.insert(item, at: Int(arc4random_uniform(UInt32(items.count))))
        }
    }
    
    func getItems() -> [NewsItem] {
        return items
    }
}
