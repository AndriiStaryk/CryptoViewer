//
//  CVFavoriteCryptosViewController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 27.08.2024.
//

import UIKit

class CVFavoriteCryptosViewController: UIViewController {

    let tableView = UITableView()
    var favorites: [Crypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        getFavorites()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
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
    
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    //self.showEmptyStateView(with: "No favorites?\nAdd one on the follower screen", in: self.view)
                    print("no favorites")
                } else {
                    self.favorites = favorites
                    print(favorites)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                //self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                print("error")
            }
        }
    }
    
}




extension CVFavoriteCryptosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CVCryptoCell.reuseID) as! CVCryptoCell
        let crypto = favorites[indexPath.row]
        cell.set(crypto: crypto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCrypto = favorites[indexPath.row]
        let destinationVC = CVCryptoViewController(crypto: selectedCrypto)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {  return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWidth(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            
            //self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
        
    }
    
}
