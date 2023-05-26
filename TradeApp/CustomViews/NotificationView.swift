//
//  NotificationView.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

class NotificationView: UIView {
  private let titleLabel = UILabel()
  private var isActive = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }
  
  private func setupUI() {
    backgroundColor = UIColor.Theme.additionalBG
    layer.cornerRadius = 12
    alpha = 0
    
    titleLabel.text = "Successfully"
    titleLabel.textAlignment = .center
    titleLabel.textColor = UIColor.Theme.text
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
  }
  
  func showAnimation() {
    guard !isActive else { return }
    isActive = true
    
    UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
      self.alpha = 1
    }) { (success) in
      if success {
        UIView.animate(withDuration: 1, delay: 1, animations: {
          self.alpha = 0
        }) { (success) in
          if success {
            self.removeFromSuperview()
            self.isActive = false
          }
        }
      }
    }
  }
}
