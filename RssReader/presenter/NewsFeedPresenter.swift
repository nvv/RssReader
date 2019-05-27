//
//  NewsPresenter.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class NewsFeedPresenter {
    
    private static let feedResourcesFile = "feed_resources"
    private static let feedResourcesKey = "FeedResources"

    
    init(view: NewsViewDelegate) {
        view.loading(isLoading: true)
        
        var feedList = [RssFeed]()
        let group = DispatchGroup()
        getFeedList().forEach { feedItem in
            let download = DispatchWorkItem {
                group.enter()
                do {
                    let rss = try self.getContent(feedItem.value)
                    feedList.append(RssFeed(XmlParser().parse(xml: rss)!))
                } catch {
                }
                group.leave()
            }

            DispatchQueue.global().async(group: group, execute: download)
        }
        
        group.notify(queue: .main) {
            view.loading(isLoading: false)
            view.showNews(newsData: NewsData(feedList: feedList))
        }
        
    }
    
    private func getFeedList() -> [String: String] {
        if let path = Bundle.main.path(forResource: NewsFeedPresenter.feedResourcesFile, ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                if let feeds = dict[NewsFeedPresenter.feedResourcesKey] {
                    if let list = feeds as? [String: String] {
                        return list
                    }
                }
            }
        }
        
        return [:]
    }
    
    private func getContent(_ url: String) throws -> String {
        return try String(contentsOf: URL(string: url)!)
    }
    

}
