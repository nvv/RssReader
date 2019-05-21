//
//  DetailedNewsViewController.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/12/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var textLines: UITextView!
    
    var rssNewsItem: NewsItem?
    
    // MARK: view functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = rssNewsItem?.title
        // Do any additional setup after loading the view.
        
        textLines.text = rssNewsItem?.description
        if let rssNewsItem = rssNewsItem {
            //print(rssNewsItem.thumbnail)
            if let thumbnail = rssNewsItem.thumbnail {
                let url = URL(string: thumbnail)
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        topImage.image = image
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
*/
}
