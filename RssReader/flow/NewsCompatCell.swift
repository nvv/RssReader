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

        setupLines(title: title, newsDescription: newsDescription, maxLines: NewsCopatCell.maxLines, maxTitleLines: NewsCopatCell.maxTitleLines)
        
    }
}
