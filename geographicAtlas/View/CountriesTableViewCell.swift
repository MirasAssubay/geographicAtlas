//
//  CountriesTableViewCell.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 12.05.2023.
//

import UIKit
import SDWebImage
import SkeletonView

protocol CountriesTableViewCellDelegate: AnyObject {
    func cellDidTapLearnMore(_ cell: CountriesTableViewCell)
}

class CountriesTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CountriesTableViewCell"
    
    weak var delegate: CountriesTableViewCellDelegate?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 12, trailing: 10)
        return stackView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor.black
        return label
    }()
    
    let countryCapitalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()
    
    let populationLabel = UILabel.makeLabel(text: "Population")
    let areaLabel = UILabel.makeLabel(text: "Area")
    let currencyLabel = UILabel.makeLabel(text: "Currencies")

    let expandableLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    let learnMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Learn More", for: .normal)
        return button
    }()
    
    @objc func learnMoreButtonTapped() {
        delegate?.cellDidTapLearnMore(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.addSubview(stackView)
        [mainStackView, expandableView].forEach{ stackView.addArrangedSubview($0) }
        [countryLabel, capitalLabel].forEach{ countryCapitalStackView.addArrangedSubview($0) }
        [flagImageView, countryCapitalStackView, chevronImageView].forEach{ mainStackView.addArrangedSubview($0) }
        [populationLabel, areaLabel, currencyLabel].forEach{ expandableLabelsStackView.addArrangedSubview($0) }
        [expandableLabelsStackView, learnMoreButton].forEach{ expandableView.addSubview($0) }
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            flagImageView.widthAnchor.constraint(equalToConstant: 82),
            
            chevronImageView.widthAnchor.constraint(equalToConstant: 18),
            chevronImageView.heightAnchor.constraint(equalToConstant: 18),
            
            countryCapitalStackView.bottomAnchor.constraint(equalTo: mainStackView.layoutMarginsGuide.bottomAnchor, constant: -8),
            
            mainStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 60),
            mainStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: stackView.layoutMarginsGuide.topAnchor),
            
            
            expandableLabelsStackView.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor),
            expandableLabelsStackView.topAnchor.constraint(equalTo: expandableView.topAnchor),
            expandableLabelsStackView.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor),
            
            learnMoreButton.topAnchor.constraint(equalTo: expandableLabelsStackView.bottomAnchor),
            learnMoreButton.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor),
            learnMoreButton.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor),
            learnMoreButton.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor)
        ])
    }
    
    func set(_ country: Country) {
        
        
        // getting only .png flag from country.flag
        var updatedCountry = country
        let pngFlags = country.flags.filter { $0.value.lowercased().hasSuffix(".png") }
        if !pngFlags.isEmpty {
            updatedCountry.flags = pngFlags
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let url = URL(string: updatedCountry.flags.values.formatted()) else {
                return
            }
            self?.flagImageView.sd_setImage(with: url)
            self?.countryLabel.text = country.name.common
            self?.capitalLabel.text = country.capital.joined(separator: ", ")
            
            
            let boldPopulation = NSMutableAttributedString(string: String(country.population).formatNumber(), attributes: [NSAttributedString.Key.font :UIFont.boldSystemFont(ofSize: 15.0)])
            let populationText = NSAttributedString(string: "Population: ")
            let text = NSMutableAttributedString(attributedString: populationText)
            text.append(boldPopulation)
            self?.populationLabel.attributedText = text
            
            let boldArea = NSMutableAttributedString(string: String(country.area).formatArea() + " km²", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)])
            let areaText = NSAttributedString(string: "Area: ")
            let formattedAreaText = NSMutableAttributedString(attributedString: areaText)
            formattedAreaText.append(boldArea)
            self?.areaLabel.attributedText = formattedAreaText
            
            let boldCurrency = NSMutableAttributedString(string: country.formatCurrencies(), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)])
            let currencyText = NSAttributedString(string: "Currency: ")
            let formattedCurrencyText = NSMutableAttributedString(attributedString: currencyText)
            formattedCurrencyText.append(boldCurrency)
            self?.currencyLabel.attributedText = formattedCurrencyText
        }
    }
}

