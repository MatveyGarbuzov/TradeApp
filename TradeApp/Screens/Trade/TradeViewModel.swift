//
//  TradeViewModel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import Foundation

class TradeViewModel {
  let title = "Trade"
  var balance = Balance(currentBalance: 10000)
  var timerStepper = Stepper(currentValue: 1)
  var investmentStepper = Stepper(currentValue: 1000)
  
  var balanceText: String {
    return balance.currentBalance.formattedWithSpace()
  }
  
  var timerStepperText: String {
    return timerStepper.currentValue.formatToTime()
  }
  
  var investmentStepperText: String {
    return investmentStepper.currentValue.formattedWithComma()
  }
  
  func changeBalance(with value: Int) {
    balance.currentBalance += value
  }
  
  func changeTimerStepper(with value: Int) {
    // Check that the timer does not go out in 1 hour
    if (value > 0 && timerStepper.currentValue + value == 3600) {
      print("Timer over 1 hour")
    } else {
      // Check that the timer does not go into negative
      if !(timerStepper.currentValue == 0 && value < 0) {
        timerStepper.currentValue += value
      }
    }
  }
  
  func changeInvestmentStepper(with value: Int) {
    // Check that the investment value doesn't go out of balance
    if (value > 0 && balance.currentBalance < investmentStepper.currentValue + value) {
      print("Investment over balance")
    } else {
      // Check that there is no investment of $ 0
      if !(investmentStepper.currentValue == 0 && value < 0) {
        investmentStepper.currentValue += value
      }
    }
  }
  
  func setTimerStepperCurrentValue(with value: Int) {
    timerStepper.currentValue = value
  }
  
  func setInvestmentStepperCurrentValue(with value: Int) {
    // Check that the investment value doesn't go out of balance
    if valueIsUnderBalance(value) {
      investmentStepper.currentValue = value
    } else {
      investmentStepper.currentValue = balance.currentBalance
    }
  }
  
  private func valueIsUnderBalance(_ value: Int) -> Bool {
    value <= balance.currentBalance
  }
}
