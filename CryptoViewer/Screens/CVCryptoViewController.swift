//
//  CVCryptoViewController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import UIKit

class CVCryptoViewController: UIViewController {

    var crypto: Crypto
    
    var header: CVCryptoHeaderTitle?
    
    init(crypto: Crypto) {
        self.crypto = crypto
        super.init(nibName: nil, bundle: nil)
        self.header = CVCryptoHeaderTitle(crypto: crypto)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        setupLayout()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = crypto.name
    }
   
    private func setupLayout() {
        guard let header = header else { return }
            view.addSubview(header)
            
            header.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    
    
}

#Preview {
    CVCryptoViewController(crypto:
                            Crypto(symbol: "ccrpt",
                                   name: "StarCoin",
                                   image: "",
                                   currentPrice: 953))
}
