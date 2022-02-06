//
//  NewsResponse.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let feed: NewsFeed?
    let items: [NewsItem]?
}

struct NewsFeed: Decodable {
    let url: String?
    let title: String?
    let link: String?
    let author, feedDescription: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case url, title, link, author
        case feedDescription = "description"
        case image
    }
}

struct NewsItem: Decodable {
    let title, pubDate: String?
    let link, guid: String?
    let author: String?
    let thumbnail: String?
    let itemDescription, content: String?
    let enclosure: Enclosure?
    let categories: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title, pubDate, link, guid, author, thumbnail
        case itemDescription = "description"
        case content, enclosure, categories
    }
}

struct Enclosure: Decodable {
    let link: String?
    let type: String?
    let thumbnail: String?
}
