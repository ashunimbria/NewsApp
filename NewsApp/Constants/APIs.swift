//
//  APIs.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

struct APIs{
    
    static let BASE_URL = "https://api.rss2json.com/"
    
    static let GET_NEWS = BASE_URL + "v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
    
}
