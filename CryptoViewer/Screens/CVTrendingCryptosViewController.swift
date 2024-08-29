//
//  CVTrendingCryptosViewController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 27.08.2024.
//

import UIKit

class CVTrendingCryptosViewController: UIViewController {

    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    let searchButton = UIBarButtonItem(systemItem: .search)
    
    var trending: [Crypto] = []
    var filteredTrending: [Crypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        configureSearchController()
        configureSearchButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetTable()
        getTrending()
    }
    

    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Trending"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CVCryptoCell.self, forCellReuseIdentifier: CVCryptoCell.reuseID)
    }
    
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cryptos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureSearchButton() {
        searchButton.target = self
        searchButton.action = #selector(didTapSearchButton)
        navigationItem.rightBarButtonItem = searchButton
        searchButton.isHidden = false
    }
    
    
    
    private func getTrending() {
        
        NetworkManager.shared.getTrendingCryptos { result in
            switch result {
            case .success(let cryptos):
                self.trending = cryptos
                self.filteredTrending = cryptos
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    
    }
    
    private func resetTable() {
        searchController.searchBar.text = ""
        searchController.isActive = false
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    @objc func didTapSearchButton() {
        navigationItem.searchController?.isActive = true
    }
    
}


extension CVTrendingCryptosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTrending.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CVCryptoCell.reuseID) as! CVCryptoCell
        let crypto = filteredTrending[indexPath.row]
        cell.set(crypto: crypto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCrypto = filteredTrending[indexPath.row]
        let destinationVC = CVCryptoViewController(crypto: selectedCrypto)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        
////        if offsetY > 10 {
//            searchButton.isHidden = false
////        } else {
////            searchButton.isHidden = true
////        }
//    }
    
}

extension CVTrendingCryptosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredTrending = trending
            tableView.reloadData()
            return
        }
        
        filteredTrending = trending.filter { crypto in
            return crypto.name.lowercased().contains(searchText.lowercased()) ||
            crypto.symbol.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
}
