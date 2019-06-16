//
//  NewsCellCompat.swift
//  RssReader
//
//  Created by Vlad Namashko on 6/2/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsCopatCell: BaseNewsCell {

    static let maxLines = 5
    static let maxTitleLines = 3
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)
        title.text = rssNewsItem?.title
        
        let totalTitleLines = title.calculateMaxLines()
        let titleLines = totalTitleLines < NewsCompatImageCell.maxTitleLines ? totalTitleLines : NewsCompatImageCell.maxTitleLines
        let descriptionLines = NewsCompatImageCell.maxLines - titleLines
        
        title.numberOfLines = titleLines <= NewsCompatImageCell.maxLines ? titleLines : NewsCompatImageCell.maxLines
        newsDescription.textContainer.maximumNumberOfLines = descriptionLines > 0 ? descriptionLines : 0
        
        newsDescription.text = descriptionLines > 0 ? rssNewsItem?.description ?? "" : ""
        
        title.text = rssNewsItem?.title
        newsDescription.text = rssNewsItem?.description
    }
}
