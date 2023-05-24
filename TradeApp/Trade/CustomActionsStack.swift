//
//  CustomActionsStack.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import UIKit

class CustomActionsStack: UIStackView {
  private let currencyPairsButton: UIButton = {
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
  
  private let timerStepper = StepperLabel()
  private let investmentStepper = StepperLabel()
  
  private let steppersHStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 10
    stack.distribution = .fillEqually
    
    return stack
  }()
  
  private let sellButton = CustomButton()
  private let buyButton = CustomButton()
  
  private let buySellHStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 10
    stack.distribution = .fillEqually
    
    return stack
  }()

  
  private let spacer = UIView()
  
  init() {
    super.init(frame: .zero)
//    self.backgroundColor = .white
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
    
    timerStepper.updateSubLabel("Timer")
    investmentStepper.updateSubLabel("Investment")
    
    sellButton.backgroundColor = UIColor.Theme.red
    sellButton.set(text: "Sell")
    buyButton.backgroundColor = UIColor.Theme.green
    buyButton.set(text: "Buy")
  }
  
  private func setupConstraints() {
    steppersHStack.addArrangedSubview(timerStepper)
    steppersHStack.addArrangedSubview(investmentStepper)
    
    buySellHStack.addArrangedSubview(sellButton)
    buySellHStack.addArrangedSubview(buyButton)
    
    addArrangedSubview(currencyPairsButton)
    addArrangedSubview(steppersHStack)
    addArrangedSubview(buySellHStack)
    addArrangedSubview(spacer)
    
    currencyPairsButton.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.width.equalToSuperview()
    }
    
    steppersHStack.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.width.equalToSuperview()
    }
    
    buySellHStack.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.width.equalToSuperview()
    }
    
    [timerStepper, investmentStepper, sellButton, buyButton].forEach({ view in
      view.snp.makeConstraints { make in
        make.height.equalToSuperview()
      }
    })
  }
  
  @objc func currencyPairsButtonPressed(_ sender: UIView) {
    print("pressed")
    sender.animateInsidePress()
  }
}
