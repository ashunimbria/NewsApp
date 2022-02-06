//
//  DatabaseManager.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

protocol Storable{
    func getNews(onSuccess: @escaping(NewsResponse) -> Void, onError: @escaping(HTTPError) -> Void)
}

class DatabaseManager{
    
    private var storage: Storable
    
    init(_storage: Storable){
        self.storage = _storage
    }
    
    func getNews(onSuccess: @escaping(NewsResponse) -> Void, onError: @escaping(HTTPError) -> Void){
        
        storage.getNews { response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
        
    }
    
}
