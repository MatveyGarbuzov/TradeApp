//
//  TradeViewModel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import Foundation

class TradeViewModel {
  var trade: TradeModel
  var url: URL
  
  var amountString: String {
    return String(format: "%.2f", trade.amount)
  }
  
  var timerString: String {
    return "\(trade.timer) sec"
  }
  
  init(trade: TradeModel, url: URL) {
    self.trade = trade
    self.url = url
  }
  
  func updateAmount(_ amount: Double) {
    trade.amount = amount
  }
  
  func updateTimer(_ timer: Int) {
    trade.timer = timer
  }
}
