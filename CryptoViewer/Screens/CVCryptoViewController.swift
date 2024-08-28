//
//  CVCryptoViewController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import UIKit

class CVCryptoViewController: UIViewController {

    var crypto: Crypto!
    
    
    init(crypto: Crypto) {
        super.init(nibName: nil, bundle: nil)
        self.crypto = crypto
        title = crypto.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
   

}
