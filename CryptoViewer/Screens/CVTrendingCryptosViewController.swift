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
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
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
        
        NetworkManager.shared.getTrendingCryptos { result in
            switch result {
            case .success(let cryptos):
                self.trending = cryptos
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    
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
