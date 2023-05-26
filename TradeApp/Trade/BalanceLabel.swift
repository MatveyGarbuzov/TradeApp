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
    animate()
    super.updateLabel(viewModel?.balanceText ?? "0")
  }
  
  func animate() {
    let curValue = Int(label.text?.replacingOccurrences(of: " ", with: "") ?? "0") ?? 0
    let newValue = viewModel?.balance.currentBalance ?? 0
    if curValue < newValue {
      self.win(label)
    } else {
      self.lose(label)
    }
  }
  
  func win(_ label: UILabel) {
    UIView.transition(with: label, duration: 0.5, options: [.transitionFlipFromTop], animations: {
      label.textColor = UIColor.Theme.green
    }) { _ in
      UIView.transition(with: label, duration: 0.5, animations: {
        label.textColor = UIColor.Theme.text
      }, completion: nil)
    }
  }
  
  func lose(_ label: UILabel) {
    UIView.transition(with: label, duration: 0.5, options: [.transitionFlipFromBottom], animations: {
      label.textColor = UIColor.Theme.red
    }) { _ in
      UIView.transition(with: label, duration: 0.5, animations: {
        label.textColor = UIColor.Theme.text
      }, completion: nil)
    }
    
  }
  
}
