//
//  NewsViewController.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, NewsViewDelegate {

    // MARK: - Properties
    @IBOutlet var collectionView: UICollectionView!
    
    private var newsData: NewsData?
    
    private var presenter: NewsFeedPresenter?
    
    private var loadingSpinner: UIView?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self

        presenter = NewsFeedPresenter(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func loading(isLoading: Bool) {
        if (isLoading) {
            let spinnerView = UIView.init(frame: self.view.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView()
            ai.activityIndicatorViewStyle = .whiteLarge
            ai.startAnimating()
            ai.center = spinnerView.center
            
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
            
            loadingSpinner = spinnerView
        } else if (loadingSpinner != nil) {
            loadingSpinner?.removeFromSuperview()
            loadingSpinner = nil
        }
    }
    
    func showNews(newsData: NewsData) {
        self.newsData = newsData
        self.collectionView.reloadData()
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsData?.getItems().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = indexPath.row % 5 == 0 ?
            collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFullCell", for: indexPath) as! BaseNewsCell :
            collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! BaseNewsCell

        if let item = newsData?.getItems()[indexPath.row] {
            cell.bind(item)
        }
        return cell 
    }
}

extension NewsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

//        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
        
        let width = indexPath.row % 5 == 0 ?
            (collectionView.bounds.size.width - 16) : ((collectionView.bounds.size.width) / 2 - 16)
        
        let height = indexPath.row % 5 == 0 ? 120 : 240
        
        return CGSize(width: width, height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}
