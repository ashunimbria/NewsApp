//
//  UIViewController.swift
//  NewsApp
//
//  Created by Ashish Nimbria on 2/5/22.
//

import UIKit

extension UIViewController{
    
    func showAlertView(alertText: String, message: String){
        
        let alert = UIAlertController(title: alertText, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
}
