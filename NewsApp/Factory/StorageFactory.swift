//
//  StorageFactory.swift
//  NewsApp
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

enum DatabaseType{
    case api
}

class StorageFactory{
    
    /*
     
     Storage Factory class will return the needed object to Database Manager.
     
     */
    
    static func create(type: DatabaseType) -> Storable{
        
        switch type{
            
        case .api:
            return APIManager()
            
        }
    }
}
