//
//  NewsViewDelegate.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

protocol NewsViewDelegate{
    
    func loading(isLoading: Bool)
    
    func showNews(newsData: NewsData)
    
}
