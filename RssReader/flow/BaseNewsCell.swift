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

}
