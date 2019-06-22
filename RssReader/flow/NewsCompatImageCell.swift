//
//  NewsCompatImageCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 6/9/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsCompatImageCell: BaseImageCell {
    
    static let maxLines = 5
    static let maxTitleLines = 3

    // MARK - UI properties
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)

        super.bind(newsItem)
        title.text = rssNewsItem?.title
        
        setupLines(title: title, newsDescription: newsDescription, maxLines: NewsCompatImageCell.maxLines, maxTitleLines: NewsCompatImageCell.maxTitleLines)

        if let url = newsItem.thumbnail {
            loadThumbnail(thumbnailUrl: url, thumbnail: thumbnail, width: thumbnail.bounds.width, height: self.bounds.height)
        }
    }
    
}

