//
//  Date.swift
//  NewsApp
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

extension String{
    
    func getFormattedDate(currentDateFormat: String, formattedTo: String) -> String? {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = currentDateFormat

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formattedTo

        if let formattedDate: Date = dateFormatterGet.date(from: self){
            return dateFormatterPrint.string(from: formattedDate)
        }else{
            return nil
        }
        
    }
    
}
