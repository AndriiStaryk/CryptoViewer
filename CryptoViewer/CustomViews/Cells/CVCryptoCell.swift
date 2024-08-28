//
//  CVCryptoCell.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 28.08.2024.
//

import UIKit

class CVCryptoCell: UITableViewCell {
    
    static let reuseID = "CryptoCell"
    
    let logo = CVCryptoLogo(frame: .zero)
    let cryptoNameLabel = CVCellLabel(textAligment: .natural, fontSize: 30)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(logo)
        addSubview(cryptoNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        cryptoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.widthAnchor.constraint(equalToConstant: 50),
            
            cryptoNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cryptoNameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: padding),
    
        ])
    }
    
    func set(crypto: Crypto) {
        cryptoNameLabel.text = crypto.name
    }
}

//#Preview {
//    CVTrendingCryptosViewController()
//}
