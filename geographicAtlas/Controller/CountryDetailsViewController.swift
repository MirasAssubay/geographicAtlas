//
//  CountryDetailsViewController.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 11.05.2023.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    var country: Country
    
    init(country: Country, cca2: String) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
        APICaller.shared.fetchCountryInfo(cca2: cca2) { [weak self] country, error in
            if let error = error {
                print("Error \(error)")
            }
            else if let country = country {
                self?.country = country
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        view.backgroundColor = .white
        title = country.name.common
        
        let countryDetailsView = CountryDetailsView()
        countryDetailsView.translatesAutoresizingMaskIntoConstraints = false
        countryDetailsView.set(country)
        view.addSubview(countryDetailsView)
        
        NSLayoutConstraint.activate([
            countryDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countryDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            countryDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
