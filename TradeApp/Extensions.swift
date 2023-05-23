//
//  Extensions.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import UIKit

extension UIColor {
  struct Theme {
    static let bg = UIColor(named: "BG")
    static let additionalBG = UIColor(named: "AdditionalBG")
    static let green = UIColor(named: "Green")
    static let red = UIColor(named: "Red")
    static let text = UIColor(named: "Text")
    static let additionalText = UIColor(named: "AdditionalText")
  }
}

// Extension to format numbers. (e.g: 10000 -> "10 000")
extension Double {
  func formatted() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = " "
    return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
  }
}
