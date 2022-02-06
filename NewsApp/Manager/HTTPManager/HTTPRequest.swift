//
//  HTTPRequest.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

protocol Request{
    var url: URL{ get set }
    var method: HTTPMethods { get set }
}

struct HTTPRequest: Request{
    var url: URL
    
    var method: HTTPMethods
    var requestBody: Data? = nil
    
    init(withUrl url: URL, forHttpMethod method: HTTPMethods, requestBody: Data? = nil){
        
        self.url = url
        self.method = method
        self.requestBody = requestBody
        
    }
    
}
