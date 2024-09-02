//
//  PersistanceManager.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 02.09.2024.
//

import Foundation

enum PersistenceActionType {
    case  add, remove
}

class PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWidth(favorite: Crypto, actionType: PersistenceActionType, completed: @escaping (CVError?) ->  Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.id == favorite.id }
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Crypto], CVError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Crypto].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Crypto]) -> CVError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            print("save")
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
