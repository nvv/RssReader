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
    
//    @IBOutlet weak var title: UILabel!
    
    // MARK - UI properties
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)

        super.bind(newsItem)
        title.text = rssNewsItem?.title
        
        let totalTitleLines = title.calculateMaxLines()
        let titleLines = totalTitleLines < NewsCompatImageCell.maxTitleLines ? totalTitleLines : NewsCompatImageCell.maxTitleLines
        let descriptionLines = NewsCompatImageCell.maxLines - titleLines
        
        title.numberOfLines = titleLines <= NewsCompatImageCell.maxLines ? titleLines : NewsCompatImageCell.maxLines
        newsDescription.textContainer.maximumNumberOfLines = descriptionLines > 0 ? descriptionLines : 0
        
        newsDescription.text = descriptionLines > 0 ? rssNewsItem?.description ?? "" : ""

        title.text = rssNewsItem?.title
    
        let width = thumbnail.bounds.width
        let height = self.bounds.height

        DispatchQueue.global().async { [weak self] in
            if let thumbnail = newsItem.thumbnail {

                let url = URL(string: thumbnail)
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.thumbnail.contentMode = .scaleAspectFit
                            let img = self?.resizeCropCenter(image: image, targetSize: CGSize(width: width, height: height), resizeAdjust: .height)
                            self?.thumbnail.image = img
                        }
                    }
                }
            }
        }
    }
    
}

