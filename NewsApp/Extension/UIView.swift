//
//  UIView.swift
//  NewsApp
//
//  Created by Ashish Nimbria on 2/5/22.
//

import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}
