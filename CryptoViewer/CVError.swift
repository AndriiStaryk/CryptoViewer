//
//  CVError.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import Foundation

enum CVError: String, Error {
    case invalidURL = "This url is invalid. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try agin"
    case alreadyInFavorites = "You've already favorited this user. You msut really like them"
}
