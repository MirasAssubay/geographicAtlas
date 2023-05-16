//
//  Countries.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 12.05.2023.
//

import Foundation
import UIKit

struct CountriesResponse: Codable {
    let results: [Country]
}

struct Country: Codable {
    let name: Name
    let population: Int
    let area: Double
    let capitalInfo: CapitalInfo
    var flags: [String: String]
    let capital: [String]
    let currencies: [String: Currency]
    let cca2: String
    let region: String
    let timezones: [String]
    
    
    // Formatting currencies to desired format. Example of returned String: Euro (€) (EUR)
    func formatCurrencies() -> String {
        var formattedCurrencies = ""
        
        for (currencyCode, currency) in currencies {
            let formattedCurrency = "\(currency.name) (\(currency.symbol!)) (\(currencyCode))"
            formattedCurrencies.append(formattedCurrency)
        }
        
        return formattedCurrencies
    }
}

struct Flag: Codable {
    let png: String
    let svg: String
}
    
struct Name: Codable {
    let common: String
}

struct CapitalInfo: Codable {
    let latlng: [Double]
}

struct Currency: Codable {
    let name: String
    let symbol: String?
}
