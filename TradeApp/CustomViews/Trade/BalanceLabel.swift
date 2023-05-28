//
//  BalanceLabel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

class BalanceLabel: CustomLabel {
  var viewModel: TradeViewModel? {
    didSet {
      updateUI()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    super.updateSubLabel("Balance")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateUI() {
    super.updateLabel(viewModel?.balanceText ?? "0")
  }
  
  func animate() {
    let curValue = Int(label.text?.replacingOccurrences(of: " ", with: "") ?? "0") ?? 0
    let newValue = viewModel?.balance.currentBalance ?? 0
    if curValue < newValue {
      self.win()
    } else {
      self.lose()
    }
  }
  
  func win() {
    UIView.transition(with: label, duration: 0.5, options: [.transitionFlipFromTop], animations: {
      self.label.textColor = UIColor.Theme.green
    }) { _ in
      UIView.transition(with: self.label, duration: 0.5, animations: {
        self.label.textColor = UIColor.Theme.text
      }, completion: nil)
    }
  }
  
  func lose() {
    UIView.transition(with: label, duration: 0.5, options: [.transitionFlipFromBottom], animations: {
      self.label.textColor = UIColor.Theme.red
    }) { _ in
      UIView.transition(with: self.label, duration: 0.5, animations: {
        self.label.textColor = UIColor.Theme.text
      }, completion: nil)
    }
    
  }
  
}
