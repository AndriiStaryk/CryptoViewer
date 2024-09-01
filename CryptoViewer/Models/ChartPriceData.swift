//
//  ChartPriceData.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 01.09.2024.
//

import Foundation

//
//struct ChartPriceData: Decodable {
//    let prices: [[Double]]
//}


struct PriceData: Decodable, Identifiable {

    let id = UUID()
    let time: Date
    let price: Double

    init(time: String, price: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = formatter.date(from: time) {
            self.time = date
        } else {
            self.time = Date()
        }
        
        self.price = price
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let timestamp = try container.decode(Double.self)
        let value = try container.decode(Double.self)
        
        self.time = Date(timeIntervalSince1970: timestamp / 1000.0)
        self.price = value
    }
}

struct ChartPriceData: Decodable {
    let prices: [PriceData]
}
