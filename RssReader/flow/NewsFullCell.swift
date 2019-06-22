//
//  NewsFullCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsFullCell: BaseImageCell {

    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    static let maxLines = 4
    static let maxTitleLines = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)
        self.title.text = rssNewsItem?.title
        
        if let url = newsItem.thumbnail {
            loadThumbnail(thumbnailUrl: url, thumbnail: thumbnail, width: self.bounds.width, height: self.bounds.height / 1.4)
        }
    }
    
    override func onThumbnailLoaded() {
        setupLines(title: title, newsDescription: newsDescription, maxLines: NewsFullCell.maxLines, maxTitleLines: NewsFullCell.maxTitleLines)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.title.text = nil
    }
    
    
}
