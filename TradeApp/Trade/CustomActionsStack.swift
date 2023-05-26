//
//  CustomActionsStack.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import UIKit

protocol BalanceChangedDelegate: AnyObject {
    func updateBalanceLabel()
}

class CustomActionsStack: UIStackView {
  weak var delegate: BalanceChangedDelegate?
  var viewModel: TradeViewModel? {
    didSet {
      updateUI()
    }
  }
  
  let haptic = HapticGenerator.shared
  
  private let timerStepper = StepperLabel()
  private let investmentStepper = StepperLabel()
  private let sellButton = CustomButton()
  private let buyButton = CustomButton()
  
  private lazy var currencyPairsButton: UIButton = {
    var container = AttributeContainer()
    container.font = UIFont.appFontBold(ofSize: 16)
    
    var config = UIButton.Configuration.filled()
    config.image = UIImage(systemName: "chevron.right")
    config.titleAlignment = .center
    config.imagePlacement = .trailing
    config.baseBackgroundColor = UIColor.Theme.additionalBG
    config.baseForegroundColor = UIColor.Theme.text
    config.attributedTitle = AttributedString("GPB/USD", attributes: container)
    
    let button = UIButton(configuration: config)
    button.addTarget(self, action: #selector(currencyPairsButtonPressed), for: .touchUpInside)
    button.contentHorizontalAlignment = .fill
    button.clipsToBounds = true
    button.tag = 1
    button.layer.cornerRadius = 12
    
    return button
  }()
  private let steppersHStack: UIStackView = {
    let stack = UIStackView()
    
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 10
    stack.distribution = .fillEqually
    
    return stack
  }()
  private let buySellHStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 10
    stack.distribution = .fillEqually
    
    return stack
  }()

  private let topSpacer = UIView()
  private let bottomSpacer = UIView()
  
  init() {
    super.init(frame: .zero)
    setupViews()
    setupConstraints()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // Getting button width to place title in center
    let buttonWidth = self.viewWithTag(1)?.frame.size.width ?? 0
    
    currencyPairsButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: buttonWidth/2 - 35, bottom: 0, trailing: 15)
  }
  
  private func setupViews() {
    self.axis = .vertical
    self.alignment = .center
    self.spacing = 8
    
    timerStepper.viewModel = viewModel
    timerStepper.stepperDelegate = self
    timerStepper.updateSubLabel("Timer")
    
    investmentStepper.viewModel = viewModel
    investmentStepper.stepperDelegate = self
    investmentStepper.updateSubLabel("Investment")
    
    sellButton.backgroundColor = UIColor.Theme.red
    sellButton.set(text: "Sell")
    sellButton.addTarget(self, action: #selector(sellButtonPressed), for: .touchUpInside)
    buyButton.backgroundColor = UIColor.Theme.green
    buyButton.set(text: "Buy")
    buyButton.addTarget(self, action: #selector(buyButtonPressed), for: .touchUpInside)
  }
  
  private func updateUI() {
    timerStepper.updateLabel(viewModel?.timerStepperText ?? "00:00")
    timerStepper.textField.text = String(viewModel?.timerStepper.currentValue ?? 0)
    
    investmentStepper.updateLabel(viewModel?.investmentStepperText ?? "0")
    investmentStepper.textField.text = String(viewModel?.investmentStepper.currentValue ?? 0)
  }
  
  private func setupConstraints() {
    steppersHStack.addArrangedSubview(timerStepper)
    steppersHStack.addArrangedSubview(investmentStepper)
    
    buySellHStack.addArrangedSubview(sellButton)
    buySellHStack.addArrangedSubview(buyButton)
    
    addArrangedSubview(topSpacer)
    addArrangedSubview(currencyPairsButton)
    addArrangedSubview(steppersHStack)
    addArrangedSubview(buySellHStack)
    addArrangedSubview(bottomSpacer)
    
    topSpacer.snp.makeConstraints { make in
      make.height.equalTo(10)
      make.width.equalToSuperview()
    }
    
    let height = min(superview?.bounds.size.height ?? 60.0, 60.0)
    [currencyPairsButton, steppersHStack, buySellHStack].forEach { view in
      view.snp.makeConstraints { make in
        make.height.equalTo(height)
        make.width.equalToSuperview().multipliedBy(0.9)
      }
    }
    
    [timerStepper, investmentStepper, sellButton, buyButton].forEach({ view in
      view.snp.makeConstraints { make in
        make.height.equalToSuperview()
      }
    })
  }
  
  private func showNotification() {
    let notification = NotificationView()
    superview?.addSubview(notification)
    notification.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.4)
      make.center.equalToSuperview()
    }
    notification.showAnimation()
  }
  
  @objc func currencyPairsButtonPressed(_ sender: UIView) {
    sender.animateInsidePress()
    updateUI()
    haptic.trigger()
  }
  
  @objc func buyButtonPressed(_ sender: UIView) {
    if viewModel?.investmentStepper.currentValue ?? 0 > 0 {
      showNotification()
    }
    viewModel?.changeBalance(with: viewModel?.investmentStepper.currentValue ?? 0)
    delegate?.updateBalanceLabel()
    
    // Checking that the investment is larger than the balance.
    // If it is larger, it automatically becomes equal to the balance
    if let balance = viewModel?.balance.currentBalance, let invest =  viewModel?.investmentStepper.currentValue {
      if invest > balance {
        viewModel?.investmentStepper.currentValue = balance
      }
    }
    sender.animateInsidePress()
    updateUI()
    haptic.trigger()
  }
  
  @objc func sellButtonPressed(_ sender: UIView) {
    showNotification()
    
    sender.animateInsidePress()
    updateUI()
    haptic.trigger()
  }
}

extension CustomActionsStack: StepperDelegate {
  func update(sender: StepperLabel) {
    print("Update from delegate")
    let senderText = sender.subLabel.text
    
    let value = Int(sender.textField.text ?? "0") ?? 0
    if senderText == "Timer" {
      viewModel?.setTimerStepperCurrentValue(with: value)
    } else if senderText == "Investment" {
      viewModel?.setInvestmentStepperCurrentValue(with: value)
    }
    
    updateUI()
  }
  
  func leftButtonTapped(sender: StepperLabel) {
    let senderText = sender.subLabel.text
    
    if senderText == "Timer" {
      viewModel?.changeTimerStepper(with: -1)
    } else if senderText == "Investment" {
      viewModel?.changeInvestmentStepper(with: -100)
    }
    updateUI()
    haptic.trigger(style: .light)
  }
  
  func rightButtonTapped(sender: StepperLabel) {
    let senderText = sender.subLabel.text
    
    if senderText == "Timer" {
      viewModel?.changeTimerStepper(with: +1)
    } else if senderText == "Investment" {
      viewModel?.changeInvestmentStepper(with: +100)
    }
    updateUI()
    haptic.trigger(style: .light)
  }
}
