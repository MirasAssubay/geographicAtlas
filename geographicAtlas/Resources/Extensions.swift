//
//  Extensions.swift
//  geographicAtlas
//
//  Created by Мирас Асубай on 12.05.2023.
//

import Foundation
import UIKit

extension UILabel {
    static func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }
    
    static func makeMultilineLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }
}

extension String {
    func attributedTextWithLightAndBoldFonts(lightFont: UIFont, boldFont: UIFont) -> NSAttributedString {
        let lightAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: lightFont, NSAttributedString.Key.foregroundColor: UIColor.black]
        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let attributedString = NSMutableAttributedString(string: self)
        
        // Find the index of the newline character
        if let newlineIndex = self.firstIndex(of: "\n") {
            let regionRange = NSRange(location: 1, length: self.distance(from: self.startIndex, to: newlineIndex))
            let countryRange = NSRange(location: self.distance(from: self.startIndex, to: newlineIndex) + 1, length: self.count - regionRange.length - 1)
            let bulletRange = NSRange(location: 0, length: 1)
            
            // Apply bold font to the bullet symbol
            attributedString.addAttributes(boldAttributes, range: bulletRange)
            
            // Apply light font to the first line
            attributedString.addAttributes(lightAttributes, range: regionRange)
            
            // Apply bold font to the second line
            attributedString.addAttributes(boldAttributes, range: countryRange)
        }
        
        return attributedString
    }
    
    func formatNumber() -> String {
        let number = Int(self) ?? 0
        
        if number >= 1_000_000 {
            let formattedNumber = String(format: "%.1f", Double(number) / 1_000_000)
            return "\(formattedNumber) mln"
        } else if number >= 1_000 {
            let formattedNumber = String(format: "%.1f", Double(number) / 1_000)
            return "\(formattedNumber) thousand"
        } else {
            return self
        }
    }
    
    func formatArea() -> String {
        guard let number = Double(self) else {
            return self
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        
        return numberFormatter.string(from: NSNumber(value: number)) ?? self
    }
}

