//
//  UIView+Ext.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
}
