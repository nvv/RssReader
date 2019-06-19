//
//  NewsData.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class NewsData {
    
    private var items = [FeedItem]()
    
    init(feedList: [RssFeed]) {
        
        feedList.forEach { feed in
            items.append(AnchorItem(item: NewsItem(item: feed.items.removeFirst())))
            
//            feed.items.forEach { item in

            var isRight = false
            for (index, item) in feed.items.enumerated() {
                if (item.thumbnail == nil) {
                    isRight = false
                    items.append(CompatItem(item: NewsItem(item: item)))
                } else if (isRight || (index < feed.items.count - 1 && feed.items[index + 1].thumbnail != nil)) {
                    isRight = !isRight
                    items.append(SmallImageItem(item: NewsItem(item: item)))
                } else {
                    isRight = false
                    items.append(CompatImageItem(item: NewsItem(item: item)))
                }
            }
        }
        
//        shuffle()
    }
    
    private func shuffle() {
        let mixingRatio = 5
        for _ in 0 ..< items.count * mixingRatio {
            let item = items.remove(at: Int(arc4random_uniform(UInt32(items.count))))
            items.insert(item, at: Int(arc4random_uniform(UInt32(items.count))))
        }
    }
    
    func getItems() -> [FeedItem] {
        return items
    }
}
