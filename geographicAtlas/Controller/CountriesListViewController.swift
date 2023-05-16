//
//  CountriesListViewController.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 11.05.2023.
//

import UIKit
import SkeletonView

enum Sections: Int {
    case Europe = 0
    case Asia = 1
    case Africa = 2
    case America = 3
    case Oceania = 4
    case Antarctic = 5
}

class CountriesListViewController: UIViewController {
    
    let SectionTitles: [String] = [
        "Europe", "Asia", "Africa", "America", "Oceania", "Antarctic"
    ]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isSkeletonable = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        title = "World Countries"
        setup()
        setupTable()
    }
    
    func setup() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupTable() {
        tableView.register(CountriesTableViewCell.self, forCellReuseIdentifier: CountriesTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    var cachedCountries: [Int: [Country]] = [:]
    
    var expandedIndexPaths: Set<IndexPath> = []

    
}

extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            // section 0 is Europe
        case Sections.Europe.rawValue:
            return 53
            // section 1 is Asia
        case Sections.Asia.rawValue:
            return 50
            // section 2 is Africa
        case Sections.Africa.rawValue:
            return 59
            // section 3 is America
        case Sections.America.rawValue:
            return 56
            // section 4 is Oceania
        case Sections.Oceania.rawValue:
            return 27
            // section 5 is Antartic
        case Sections.Antarctic.rawValue:
            return 5
        default:
            return 10
        }
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseIdentifier, for: indexPath) as? CountriesTableViewCell else {
            print("I'm UITableViewCell")
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        cell.isSkeletonable = true
        cell.showGradientSkeleton()
        cell.delegate = self
        if let cachedSectionCountries = cachedCountries[indexPath.section] {
            // If the countries for this section are already cached, use them
            let country = cachedSectionCountries[indexPath.row]
            cell.set(country)
        } else {
            // If the countries for this section are not cached, fetch them
            switch indexPath.section {
            case Sections.Europe.rawValue:
                APICaller.shared.fetchEuropeCountries { [weak self] countries, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let countries = countries {
                        // Process the retrieved countries here
                        self?.cachedCountries[indexPath.section] = countries
                        DispatchQueue.main.async {
                            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                        }
                    }
                }
            case Sections.Asia.rawValue:
                APICaller.shared.fetchAsiaCountries { [weak self] countries, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let countries = countries {
                        self?.cachedCountries[indexPath.section] = countries
                        DispatchQueue.main.async {
                            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                        }
                    }
                }
            case Sections.Africa.rawValue:
                APICaller.shared.fetchAfricaCountries { [weak self] countries, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let countries = countries {
                        self?.cachedCountries[indexPath.section] = countries
                        DispatchQueue.main.async {
                            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                        }
                    }
                }
            case Sections.America.rawValue:
                APICaller.shared.fetchAmericaCountries { [weak self] countries, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let countries = countries {
                        self?.cachedCountries[indexPath.section] = countries
                        DispatchQueue.main.async {
                            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                        }
                    }
                }
            case Sections.Oceania.rawValue:
                APICaller.shared.fetchOceaniaCountries { [weak self] countries, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let countries = countries {
                        self?.cachedCountries[indexPath.section] = countries
                        DispatchQueue.main.async {
                            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                        }
                    }
                }
            case Sections.Antarctic.rawValue:
                APICaller.shared.fetchAntarcticCountries { [weak self] countries, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let countries = countries {
                        self?.cachedCountries[indexPath.section] = countries
                        DispatchQueue.main.async {
                            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                        }
                    }
                }
            default:
                return UITableViewCell()
            }
        }
        
        
        //MARK: - ONLY FOR DEMONSTRATION OF SKELETON VIEW, COMMENT OR DELETE DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) TO GET RID OF LOADING TABLEVIEWCELLS
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cell.hideSkeleton()
        }
        
        
        // Adding expandable feature for each cell
        let isExpanded = expandedIndexPaths.contains(indexPath)
        cell.expandableView.isHidden = !isExpanded
        cell.chevronImageView.image = (isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"))?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Expanding tableViewCells
        if expandedIndexPaths.contains(indexPath) {
            expandedIndexPaths.remove(indexPath)
        }
        else {
            expandedIndexPaths.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let section = indexPath.section
                let row = indexPath.row
        guard let countriesInSection = cachedCountries[section], row < countriesInSection.count else {
            return
        }
        print(countriesInSection[row].cca2)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: tableView.frame.width, height: 30))
        switch section {
        case 0:
            label.text = "EUROPE"
        case 1:
            label.text = "ASIA"
        case 2:
            label.text = "AFRICA"
        case 3:
            label.text = "AMERICA"
        case 4:
            label.text = "OCEANIA"
        case 5:
            label.text = "ANTARCTIC"
        default:
            label.text = "Out of range"
        }
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension CountriesListViewController: CountriesTableViewCellDelegate {
    func cellDidTapLearnMore(_ cell: CountriesTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let section = indexPath.section
        let row = indexPath.row
        guard let countriesInSection = cachedCountries[section], row < countriesInSection.count else {
            return
        }
        
        let selectedCountry = countriesInSection[row]
        let countryDetailsVC = CountryDetailsViewController(country: selectedCountry, cca2: selectedCountry.cca2)
        navigationController?.pushViewController(countryDetailsVC, animated: true)
        print("I'm tapped")
    }
}

