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
}
