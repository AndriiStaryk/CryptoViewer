//
//  CVTrendingCryptosViewController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 27.08.2024.
//

import UIKit

class CVTrendingCryptosViewController: UIViewController {

    let tableView = UITableView()
    var trending: [Crypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTrending()
    }
    

    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Trending"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CVCryptoCell.self, forCellReuseIdentifier: CVCryptoCell.reuseID)
    }
    
    
    private func getTrending() {
        trending = [
            Crypto(name: "BTC"),
            Crypto(name: "ETH"),
            Crypto(name: "TON"),
            Crypto(name: "NOT"),
        ]
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            self.view.bringSubviewToFront(self.tableView)
//        }
    }
}


extension CVTrendingCryptosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trending.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CVCryptoCell.reuseID) as! CVCryptoCell
        let crypto = trending[indexPath.row]
        cell.set(crypto: crypto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCrypto = trending[indexPath.row]
        let destinationVC = CVCryptoViewController(crypto: selectedCrypto)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
