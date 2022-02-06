//
//  ViewController.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var tblNews: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var headerView: UIView!
    
    var news = [NewsItem]()
    
    lazy var refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNews.tableFooterView = UIView()
        addRefresherToTableView()
        getNews()
        
    }
    
    private func addRefresherToTableView() {
        refresher.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tblNews.refreshControl = refresher
    }
    
    @objc private func refreshTableView(){
        getNews()
    }
    
    //MARK: - Get data from database source
    
    private func getNews(){
        
        news.removeAll()
        
        /*
         - Do not pass concrete object directly. StorageFactory will create object to get the data from API.
         - DatabaseManager will get the data from the class which you are passing through factory class. For ex: If you want to get data from any database source then add that class to factory and change factory type here.
         
         */
        
        let databaseManager = DatabaseManager(_storage: StorageFactory.create(type: .api))
        
        databaseManager.getNews { response in
            if response.status == "ok"{
                if let newsItems = response.items{
                    self.news = newsItems
                    self.setHeaderNewsData(newsItem: newsItems[0])
                    print("Data received")
                    DispatchQueue.main.async {
                        self.refresher.endRefreshing()
                        self.tblNews.reloadData()
                        self.tblNews.isHidden = false
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.showAlertView(alertText: "Alert", message: "Something went wrong. Please try again later.")
                    self.tblNews.isHidden = true
                }
            }
            
        } onError: { error in
            self.showAlertView(alertText: "Alert", message: error.localizedDescription)
        }
        
    }
    
    //MARK: - Setting news data to top article
    
    func setHeaderNewsData(newsItem: NewsItem){
        
        let date = newsItem.pubDate?.getFormattedDate(currentDateFormat: "yyyy-MM-dd HH:mm:ss", formattedTo: "MMM d, yyyy")
        let time = newsItem.pubDate?.getFormattedDate(currentDateFormat: "yyyy-MM-dd HH:mm:ss", formattedTo: "hh:mm a")
        
        DispatchQueue.main.async {
            self.lblTitle.text = newsItem.title
            self.lblDate.text = date
            self.lblTime.text = time
            self.imgThumbnail.kf.setImage(with: URL(string: newsItem.enclosure?.thumbnail?.replacingOccurrences(of: "&amp;", with: "&") ?? "")!, placeholder: UIImage())
            
            /*
              layoutTableHeaderView() method will set Header View height according to its content height.
            */
            
            self.tblNews.layoutTableHeaderView()
        }
    }
}
