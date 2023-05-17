//
//  CountryDetailsViewTest.swift
//  geographicAtlasTests
//
//  Created by Мирас Асубай on 17.05.2023.
//

import XCTest
@testable import geographicAtlas

final class CountryDetailsViewTest: XCTestCase {
    
    var countryDetailsView: CountryDetailsView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        countryDetailsView = CountryDetailsView()
    }

    override func tearDownWithError() throws {
        countryDetailsView = nil
        
        try super.tearDownWithError()
    }
    
    func testSettingCountryData() {
        let country = Country(name: Name(common: "Test Country"),
                              population: 1000000,
                              area: 1000,
                              capitalInfo: CapitalInfo(latlng: [50.0, 60.0]),
                              flags: ["png": "Russia"],
                              capital: ["Test Capital"],
                              currencies: ["USD": Currency(name: "US Dollar", symbol: "$")],
                              cca2: "TH",
                              region: "Europe",
                              timezones: ["GMT+1", "GMT+2"])
        
        // When
        
        
        countryDetailsView.set(country)
        
        
        let bullet = "\u{2022}"
        let lightFont = UIFont.systemFont(ofSize: 15, weight: .light)
        let boldFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let regionText = "\(bullet) Region:\n   \(country.region)"
        let expectedRegionText = regionText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
        
        XCTAssertNotNil(countryDetailsView.regionLabel.attributedText, "regionLabel should not be nil")
        XCTAssertEqual(countryDetailsView.regionLabel.attributedText, expectedRegionText)
        
        let populationText = "\(bullet) Population:\n   \(String(country.population).formatNumber())"
        let expectedPopulationText = populationText.attributedTextWithLightAndBoldFonts(lightFont: lightFont, boldFont: boldFont)
        
        XCTAssertNotNil(countryDetailsView.populationLabel.attributedText, "populationLabel should not be nil")
        XCTAssertEqual(countryDetailsView.populationLabel.attributedText, expectedPopulationText)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
