//
//  RssFeed.swift
//  RssReader
//
//  Created by Vlad Namashko on 4/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class RssFeed {
    
    private static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss ZZZ"
        return formatter
    }()
    
    let title: String?
    let description: String?
    let link: String?
    let date: Date?
    let copyright: String?
    let language: String?
    var items = [Item]()
    
    init(_ rss: XmlNode) {
        let channel = rss.getChild("channel")
        
        title = channel?.getChild("title")?.value
        description = channel?.getChild("description")?.value
        link = channel?.getChild("link")?.value
        
        if let dateValue = channel?.getChild("lastBuildDate")?.value {
            date = RssFeed.dateFormatter.date(from: dateValue)
        } else {
            date = Date()
        }
        
        copyright = channel?.getChild("copyright")?.value
        language = channel?.getChild("language")?.value
        
        channel?.getChildren("item")?.forEach {
            items.append(Item($0))
        }
    }

    class Item {
        var title: String?
        let description: String?
//        let thumbnail: Thumbnail
        let thumbnail: String?
        
        init(_ node: XmlNode?) {
            title = node?.getChild("title")?.value
            description = node?.getChild("description")?.value
//            thumbnail = Thumbnail(node?.getChild("media:thumbnail"))
            thumbnail = node?.getChild("image")?.value
        }
        /*
        class Thumbnail {
            let width: Int
            let height: Int
            let url: String
            
            init(_ thumbnail: XmlNode?) {
                width = Int((thumbnail?.attributes?["width"])!)!
                height = Int((thumbnail?.attributes?["height"])!)!
                url = (thumbnail?.attributes?["url"])!
            }
        }
         */
    }
}

