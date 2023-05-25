//
//  HapticGenerator.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 25.05.2023.
//

import UIKit

class HapticGenerator {
  static let shared = HapticGenerator()
  
  func trigger(style:  UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
    
    feedbackGenerator.prepare()
    feedbackGenerator.impactOccurred()
  }
}
