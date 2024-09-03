//
//  CVCryptoHeaderTitle.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import UIKit


protocol CVCryptoHeaderTitleDelegate: AnyObject {
    func didTapFavoriteButton(for crypto: Crypto, action: PersistenceActionType)
}


class CVCryptoHeaderTitle: UIView {
    
    var crypto: Crypto?
    var logo = CVCryptoLogo(frame: .zero)
    var cryptoNameLabel = UILabel()
    var cryptoSymbolLabel = UILabel()
    var makeFavoriteButton = UIButton()
    var priceLabel = UILabel()
    var percentLabel = UILabel()
    
    weak var delegate: CVCryptoHeaderTitleDelegate?
    private var isAdding: Bool = true {
        didSet {
            updateButtonAppearance()
        }
    }
    
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
        
        PersistenceManager.isCryptoFavorite(crypto: crypto) { [weak self] isFavorite in
            guard let self = self else { return }
            self.isAdding = !isFavorite
        }
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func favoriteButtonTapped() {
        guard let crypto = crypto else { return }
        let actionType: PersistenceActionType = isAdding ? .add : .remove
        delegate?.didTapFavoriteButton(for: crypto, action: actionType)
        isAdding.toggle()
    }
    
    private func updateButtonAppearance() {
        DispatchQueue.main.async {
            let heartImage = self.isAdding ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
            self.makeFavoriteButton.setImage(heartImage, for: .normal)
        }
    }
    
    private func configure() {
        addSubviews(logo, cryptoNameLabel, cryptoSymbolLabel, makeFavoriteButton, priceLabel, percentLabel)
        configureUpperLabels()
        configureBottomLabels()
        configureButton()
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
    
    private func configureButton() {
        let heartImageEmpty = UIImage(systemName: "heart")
        makeFavoriteButton.setImage(heartImageEmpty, for: .normal)
        makeFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        makeFavoriteButton.tintColor = .systemRed
        makeFavoriteButton.contentMode = .scaleAspectFit
        
        makeFavoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
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
            
            makeFavoriteButton.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            makeFavoriteButton.leadingAnchor.constraint(equalTo: cryptoSymbolLabel.trailingAnchor, constant: spacing),
            makeFavoriteButton.widthAnchor.constraint(equalToConstant: 44),
            makeFavoriteButton.heightAnchor.constraint(equalToConstant: 44),
            
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
