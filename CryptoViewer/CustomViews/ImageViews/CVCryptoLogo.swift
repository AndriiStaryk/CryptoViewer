//
//  CVCryptoLogo.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 28.08.2024.
//

import UIKit

class CVCryptoLogo: UIImageView {

    let logo: UIImage = UIImage(systemName: "coloncurrencysign.circle.fill")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = logo
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
