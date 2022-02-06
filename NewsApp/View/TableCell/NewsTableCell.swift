//
//  NewsTableCell.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import UIKit
import Kingfisher

class NewsTableCell: UITableViewCell {

    var newsItem: NewsItem?{
        didSet{
            guard let news = newsItem else { return }
            
            let date = news.pubDate?.getFormattedDate(currentDateFormat: "yyyy-MM-dd HH:mm:ss", formattedTo: "MMM d, yyyy")
            let time = news.pubDate?.getFormattedDate(currentDateFormat: "yyyy-MM-dd HH:mm:ss", formattedTo: "hh:mm a")
            
            DispatchQueue.main.async {
                self.lblTitle.text = news.title
                self.lblDate.text = date
                self.lblTime.text = time
                self.imgThumbnail.kf.setImage(with: URL(string: news.thumbnail?.replacingOccurrences(of: "&amp;", with: "&") ?? "")!, placeholder: UIImage())
            }
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
