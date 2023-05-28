//
//  CustomCollectionCell.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 28.05.2023.
//

import UIKit
import SnapKit

protocol CollectionButtonDelegate: AnyObject {
  func popView(with currencyPair: String)
}

class CustomCollectionViewCell: UICollectionViewCell {
  weak var delegate: CollectionButtonDelegate?
  var title: String?
  
  private lazy var button: UIButton = {
    var container = AttributeContainer()
    container.font = UIFont.appFontBold(ofSize: 14)
    
    var config = UIButton.Configuration.filled()
    config.imagePlacement = .trailing
    config.baseBackgroundColor = UIColor.clear
    config.baseForegroundColor = UIColor.Theme.text
    config.attributedTitle = AttributedString("Pair", attributes: container)
    
    let button = UIButton(configuration: config)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    button.contentHorizontalAlignment = .fill
    button.clipsToBounds = true
    button.tag = 1
    button.layer.cornerRadius = 12
    
    return button
  }()
  

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    setupConstraints()
  }
  
  private func setup() {
    contentView.backgroundColor = UIColor.Theme.additionalBG
    contentView.layer.cornerRadius = 12
    contentView.layer.masksToBounds = true
  }
  
  private func setupConstraints() {
    contentView.addSubview(button)
    button.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
  }
  
  func updatetitle(_ title: String) {
    var container = AttributeContainer()
    container.font = UIFont.appFontBold(ofSize: 14)
    button.configuration?.attributedTitle = AttributedString(title, attributes: container)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func buttonTapped() {
    let currencyPair = button.titleLabel?.text ?? "qqqqqq"
    print("- CustomCell. CurrencyPair: \(currencyPair)")
    delegate?.popView(with: currencyPair)
  }
}

