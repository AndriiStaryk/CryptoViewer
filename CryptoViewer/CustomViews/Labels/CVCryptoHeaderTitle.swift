//
//  CVCryptoHeaderTitle.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import UIKit

class CVCryptoHeaderTitle: UIView {
    
    var crypto: Crypto?
    var logo = CVCryptoLogo(frame: .zero)
    var cryptoNameLabel = UILabel()
    var cryptoSymbolLabel = UILabel()
    var priceLabel = UILabel()
    var percentLabel = UILabel()
    
    
    convenience init(crypto: Crypto) {
        self.init(frame: .zero)
        self.crypto = crypto
        cryptoNameLabel.text = crypto.name
        cryptoSymbolLabel.text = crypto.symbol
        priceLabel.text = "$ " + String(crypto.currentPrice)
        percentLabel.text = "percent"
        NetworkManager.shared.downloadImage(from: crypto.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.logo.image = image }
        }
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(logo, cryptoNameLabel, cryptoSymbolLabel, priceLabel, percentLabel)
        configureUpperLabels()
        configureBottomLabels()
        configureUILayout()
    }
    
    
    private func configureUpperLabels() {
        cryptoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoNameLabel.textColor = .label
        cryptoNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        cryptoNameLabel.adjustsFontSizeToFitWidth = true
        cryptoNameLabel.adjustsFontForContentSizeCategory = true
        cryptoNameLabel.minimumScaleFactor = 0.8
        cryptoNameLabel.lineBreakMode = .byWordWrapping
        
        cryptoSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoSymbolLabel.textColor = .black
        cryptoSymbolLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        cryptoSymbolLabel.adjustsFontSizeToFitWidth = true
        cryptoSymbolLabel.adjustsFontForContentSizeCategory = true
        cryptoSymbolLabel.minimumScaleFactor = 0.8
        cryptoSymbolLabel.lineBreakMode = .byWordWrapping
    }
    
    
    private func configureBottomLabels() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .systemGray
        priceLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.minimumScaleFactor = 0.8
        priceLabel.lineBreakMode = .byWordWrapping
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.textColor = .systemGray
        percentLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        percentLabel.adjustsFontSizeToFitWidth = true
        percentLabel.adjustsFontForContentSizeCategory = true
        percentLabel.minimumScaleFactor = 0.8
        percentLabel.lineBreakMode = .byWordWrapping
    }
    
    private func configureUILayout() {
        
        let padding: CGFloat = 15
        let spacing: CGFloat = 10
        let upperHeaderHeight: CGFloat = 50
        let bottomHeaderHeight: CGFloat = 35
        
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            logo.heightAnchor.constraint(equalToConstant: upperHeaderHeight),
            logo.widthAnchor.constraint(equalToConstant: upperHeaderHeight),
            
            cryptoNameLabel.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            cryptoNameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: spacing),
            cryptoNameLabel.heightAnchor.constraint(equalToConstant: upperHeaderHeight),
            
            cryptoSymbolLabel.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            cryptoSymbolLabel.leadingAnchor.constraint(equalTo: cryptoNameLabel.trailingAnchor, constant: spacing),
            cryptoSymbolLabel.heightAnchor.constraint(equalToConstant: upperHeaderHeight),
            
            priceLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: spacing),
            priceLabel.leadingAnchor.constraint(equalTo: logo.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: bottomHeaderHeight),
            
            percentLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: spacing),
            percentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: spacing),
            percentLabel.heightAnchor.constraint(equalToConstant: bottomHeaderHeight)
            
        ])
    }
    
}


//#Preview {
//    CVCryptoHeaderTitle()
//}
