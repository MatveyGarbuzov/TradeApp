//
//  TradeCell.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 27.05.2023.
//

import UIKit

class TopTraderCell: UITableViewCell {
  
  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .equalSpacing
    
    return stack
  }()
  
  private let numberLabel = UILabel()
//  private let countryLabel = UILabel()
  private let countryLabel = UIImageView()
  private let nameLabel = UILabel()
  private let depositLabel = UILabel()
  private let profitLabel = UILabel()
  
  var model: TopTraderCellModel? {
    didSet {
      guard let model = model else { return }
      print("DIDSET")
      numberLabel.text = "\(model.number)"
      countryLabel.image = model.country.image
      nameLabel.text = model.name
      depositLabel.text = model.deposit
      profitLabel.text = model.profit
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(stackView)
    stackView.addSubview(numberLabel)
    stackView.addSubview(countryLabel)
    stackView.addSubview(nameLabel)
    stackView.addSubview(depositLabel)
    stackView.addSubview(profitLabel)
    setupLabels()
    
    
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(contentView)
    }
    let width = contentView.bounds.size.width
    print(width)
    
    numberLabel.snp.makeConstraints { make in
      make.leading.top.bottom.equalToSuperview().inset(10)
      make.width.equalTo(contentView.snp.width).multipliedBy(0.08)
    }
    
    countryLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(10)
      make.leading.equalTo(numberLabel.snp.trailing).offset(10)
      make.width.equalTo(contentView.snp.width).multipliedBy(0.08)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(10)
      make.leading.equalTo(countryLabel.snp.trailing).offset(width*0.13)
      make.width.equalTo(contentView.snp.width).multipliedBy(0.19)
    }
    
    depositLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(10)
      make.trailing.equalTo(profitLabel.snp.leading).offset(-10)
      make.width.equalTo(contentView.snp.width).multipliedBy(0.17)
    }
    
    profitLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(10)
      make.trailing.equalToSuperview().inset(10)
      make.width.equalTo(contentView.snp.width).multipliedBy(0.21)
    }
  }
  
  private func setupLabels() {
    [numberLabel, nameLabel, depositLabel, profitLabel].forEach { label in
      label.font = UIFont.appFontMedium(ofSize: 14)
      label.textColor = UIColor.Theme.text
    }
    
    depositLabel.textAlignment = .right
    profitLabel.textAlignment = .right
    profitLabel.textColor = UIColor.Theme.green
  }
  
  func updateProfit(with text: String) {
    profitLabel.text = text
    profitLabel.addGlowAnimation(duration: 1.0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UILabel {
  func addGlowAnimation(duration: TimeInterval) {
    
    // Add the animation
    let animation = CABasicAnimation(keyPath: "shadowOpacity")
    animation.fromValue = 0.0
    animation.toValue = 1.0
    animation.duration = duration
    animation.autoreverses = true
    
    // Apply the animation
    self.layer.shadowColor = UIColor.white.cgColor
    self.layer.shadowRadius = 8.0
    self.layer.shadowOpacity = 1.0
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.add(animation, forKey: "glow")
    
    // After the animation completes, remove the effect
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      UIView.animate(withDuration: duration, animations: {
        self.layer.removeAllAnimations()
        self.layer.shadowOpacity = 0.0
      })
    }
  }
}


