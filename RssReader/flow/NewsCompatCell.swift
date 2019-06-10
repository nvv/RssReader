//
//  NewsCellCompat.swift
//  RssReader
//
//  Created by Vlad Namashko on 6/2/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsCopatCell: BaseNewsCell {

    @IBOutlet weak var title: UILabel!
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)
        self.title.text = rssNewsItem?.title
//        self.description.text = rssNewsItem?.description
    }
    
}
