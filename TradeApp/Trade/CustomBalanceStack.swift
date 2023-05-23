//
//  CustomBalanceStack.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import UIKit

class CustomBalanceStack: UIStackView {
  private let balanceTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Balance"
    label.font = UIFont.appFontMedium(ofSize: 12)
    label.textColor = UIColor.Theme.additionalText
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let balanceAmountLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = UIFont.appFontBold(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let spacer = UIView()
  
  init() {
    super.init(frame: .zero)
    self.backgroundColor = UIColor.Theme.additionalBG
    self.layer.cornerRadius = 12
    setupViews()
    setupConstraints()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    axis = .vertical
    alignment = .center
    
    addArrangedSubview(balanceTitleLabel)
    addArrangedSubview(balanceAmountLabel)
  }
  
  private func setupConstraints() {
    balanceTitleLabel.snp.makeConstraints { make in
      make.height.equalTo(20)
    }
    balanceAmountLabel.snp.makeConstraints { make in
      make.height.equalTo(30)
    }
  }
  
  func setBalanceAmount(_ amount: Double) {
    print("setBalanceAmount")
    balanceAmountLabel.text = amount.formatted()
  }
}
