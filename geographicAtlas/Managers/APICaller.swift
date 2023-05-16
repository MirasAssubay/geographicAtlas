//
//  APICaller.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 13.05.2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func fetchEuropeCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/region/europe?fields=name,population,area,capitalInfo,flags,capital,currencies,cca2,region,timezones")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
    
    func fetchAsiaCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/region/asia?fields=name,population,area,capitalInfo,flags,capital,currencies,cca2,region,timezones")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
    
    func fetchAfricaCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/region/africa?fields=name,population,area,capitalInfo,flags,capital,currencies,cca2,region,timezones")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
    
    func fetchAmericaCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/region/america?fields=name,population,area,capitalInfo,flags,capital,currencies,cca2,region,timezones")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
    
    func fetchOceaniaCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/region/oceania?fields=name,population,area,capitalInfo,flags,capital,currencies,cca2,region,timezones")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
    
    func fetchAntarcticCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/region/antarctic?fields=name,population,area,capitalInfo,flags,capital,currencies,cca2,region,timezones")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
    func fetchCountryInfo(cca2: String, completion: @escaping (Country?, Error?) -> Void) {
        let url = URL(string: "https://restcountries.com/v3.1/alpha?codes=\(cca2)")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                guard let country = countries.first else {
                    completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                    return
                }
                completion(country, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }

}
