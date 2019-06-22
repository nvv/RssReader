//
//  NewsCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsSmallCell: BaseImageCell {
    
    static let maxLines = 4
    static let maxTitleLines = 3
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)
        title.text = rssNewsItem?.title
        
        if let url = newsItem.thumbnail {
            loadThumbnail(thumbnailUrl: url, thumbnail: thumbnail, width: self.bounds.width, height: self.bounds.height / 1.8)
        }
    }
    
    override func onThumbnailLoaded() {
//        let totalTitleLines = title.calculateMaxLines()
//        let titleLines = totalTitleLines < NewsSmallCell.maxTitleLines ? totalTitleLines : NewsSmallCell.maxTitleLines
//        let descriptionLines = NewsSmallCell.maxLines - titleLines
//
//        title.numberOfLines = titleLines <= NewsSmallCell.maxLines ? titleLines : NewsSmallCell.maxLines
//        newsDescription.textContainer.maximumNumberOfLines = descriptionLines > 0 ? descriptionLines : 0
//
//        newsDescription.text = descriptionLines > 0 ? rssNewsItem?.description ?? "" : ""
//        title.text = rssNewsItem?.title
        setupLines(title: title, newsDescription: newsDescription, maxLines: NewsSmallCell.maxLines, maxTitleLines: NewsSmallCell.maxTitleLines)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsDescription.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        newsDescription.text = nil
    }
}
