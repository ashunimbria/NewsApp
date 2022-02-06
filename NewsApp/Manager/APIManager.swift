//
//  NewsResource.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

struct APIManager: Storable{
    
    func getNews(onSuccess: @escaping (NewsResponse) -> Void, onError: @escaping (HTTPError) -> Void) {
        
        let request = HTTPRequest(withUrl: URL(string: APIs.GET_NEWS)!, forHttpMethod: .get, requestBody: nil)
        
        HTTPManager.shared.request(request: request, resultType: NewsResponse.self) { result in
            
            switch result{
            case .success(let response):
                onSuccess(response!)
                break
            case .failure(let error):
                onError(error)
                break
            }
        }
    }
}
