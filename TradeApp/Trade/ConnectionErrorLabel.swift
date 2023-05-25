//
//  ConnectionErrorLabel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 25.05.2023.
//

import UIKit

class ConnectionErrorLabel: CustomLabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    super.updateSubLabel("No internet connection")
    super.updateLabel("Try restarting the app")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
