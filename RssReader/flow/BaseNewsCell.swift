//
//  BaseNewsCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class BaseNewsCell: UICollectionViewCell {

    internal var rssNewsItem: FeedItem?
    
    func bind(_ newsItem: FeedItem) {
        rssNewsItem = newsItem
    }

    internal func setupLines(title: UILabel, newsDescription: UITextView, maxLines: Int, maxTitleLines: Int) {
        let totalTitleLines = title.calculateMaxLines()
        let titleLines = totalTitleLines < maxTitleLines ? totalTitleLines : maxTitleLines
        let descriptionLines = maxLines - titleLines
        
        title.numberOfLines = titleLines <= maxLines ? titleLines : maxLines
        newsDescription.textContainer.maximumNumberOfLines = descriptionLines > 0 ? descriptionLines : 0
        
        newsDescription.text = descriptionLines > 0 ? rssNewsItem?.description ?? "" : ""
        title.text = rssNewsItem?.title
    }
    
}
