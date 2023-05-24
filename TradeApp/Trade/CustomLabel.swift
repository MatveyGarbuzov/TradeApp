//
//  CustomLabel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

class CustomLabel: UIView {
  let subLabel: UILabel = {
    let label = UILabel()
//    label.text = "Timer"
    label.font = UIFont.appFontMedium(ofSize: 12)
    label.textColor = UIColor.Theme.additionalText
    label.textAlignment = .center
    return label
  }()
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "00:00"
    label.font = UIFont.appFontBold(ofSize: 16)
    label.textAlignment = .center
    return label
  }()
  
  let stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillProportionally

    return stack
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.Theme.additionalBG
    layer.cornerRadius = 12
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    addSubview(stackView)
    stackView.addArrangedSubview(subLabel)
    stackView.addArrangedSubview(label)
    
    label.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.75)
      make.width.equalToSuperview()
    }
    
    subLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(5)
      make.height.equalToSuperview().multipliedBy(0.25)
      make.width.equalToSuperview()
    }

    stackView.snp.makeConstraints { make in
      make.height.equalTo(50)
      make.width.equalToSuperview().multipliedBy(0.6)
      make.center.equalToSuperview()
    }
  }
  
   func updateLabel(_ value: String) {
    self.label.text = value
  }
  
  func updateSubLabel(_ value: String) {
    self.subLabel.text = value
  }
}
