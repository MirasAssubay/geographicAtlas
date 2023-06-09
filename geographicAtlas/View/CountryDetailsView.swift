//
//  CountryDetailsView.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 14.05.2023.
//

import UIKit
import CoreLocation
import MapKit

class CountryDetailsView: UIScrollView {
    
    var capitalCoordinates: [Double]? = [Double]()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let regionLabel = UILabel.makeMultilineLabel()
    let capitalLabel = UILabel.makeMultilineLabel()
    let capitalCoordsLabel = UILabel.makeMultilineLabel()
    let populationLabel = UILabel.makeMultilineLabel()
    let areaLabel = UILabel.makeMultilineLabel()
    let currencyLabel = UILabel.makeMultilineLabel()
    let timezoneLabel = UILabel.makeMultilineLabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(contentView)
        contentView.addSubview(flagImageView)
        [regionLabel, capitalLabel, capitalCoordsLabel, populationLabel, areaLabel, currencyLabel, timezoneLabel].forEach { stackView.addArrangedSubview($0) }
        contentView.addSubview(stackView)
        
        // making capitalCoordsLabel tappable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        capitalCoordsLabel.isUserInteractionEnabled = true
        capitalCoordsLabel.addGestureRecognizer(tapGesture)

        setConstraints()
    }
    
    func set(_ country: Country) {
        
        capitalCoordinates = country.capitalInfo.latlng
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
            
            // Formatting each of the label to be in format of design (Bullet - bold, first line - light, second line - bold)
            let bullet = "\u{2022}"
            let lightFont = UIFont.systemFont(ofSize: 15, weight: .light)
            let boldFont = UIFont.systemFont(ofSize: 18, weight: .bold)
            
            let regionText = "\(bullet) Region:\n   \(country.region)"
            self?.regionLabel.attributedText = regionText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
            let capitalText = "\(bullet) Capital:\n   \(country.capital.joined(separator: ",\n   "))"
            self?.capitalLabel.attributedText = capitalText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
            let capitalCoordsText = "\(bullet) Capital coordinates:\n   \((country.capitalInfo.latlng))"
            self?.capitalCoordsLabel.attributedText = capitalCoordsText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
            let population = String(country.population).formatNumber()
            let populationText = "\(bullet) Population:\n   \(population)"
            self?.populationLabel.attributedText = populationText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
            let areaText = "\(bullet) Area:\n   \(String(country.area).formatArea()) km²"
            self?.areaLabel.attributedText = areaText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
            let formattedCurrencies = country.formatCurrencies()
            let currencyText = "\(bullet) Currency:\n   \(formattedCurrencies)"
            self?.currencyLabel.attributedText = currencyText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
            let timezoneText = "\(bullet) Timezones:\n   \(country.timezones.joined(separator: "\n   "))"
            self?.timezoneLabel.attributedText = timezoneText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
            
        }
    }

    
    private func setConstraints() {
            let contentViewConstraints = [
                contentView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
                contentView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
                contentView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(contentViewConstraints)

            let margins = contentView.layoutMarginsGuide
            let padding: CGFloat = 16.0

            NSLayoutConstraint.activate([
                flagImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                flagImageView.topAnchor.constraint(equalTo: margins.topAnchor),
                flagImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                flagImageView.heightAnchor.constraint(equalToConstant: 200),

                stackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: padding),
                stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
}


//MARK: - Make capitalCoordsLabel to open map on click
extension CountryDetailsView {
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let coords = capitalCoordinates {
            // Opening map with coordinates
            openMapWithCoordinates(latitude: coords[0], longitude: coords[1])
        }
    }

    func openMapWithCoordinates(latitude: Double, longitude: Double) {
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: locationCoordinate))
        mapItem.name = "Capital"
        // Open the map using map items
        mapItem.openInMaps(launchOptions: nil)
    }
}
