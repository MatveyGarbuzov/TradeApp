//
//  CustomStepperButton.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

class CustomStepper: UIView {
  private let button: UIButton = {
    let button = UIButton()
    button.tintColor = UIColor.Theme.additionalText
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(button)
    
    button.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func setImage(_ image: UIImage) {
    button.setImage(image, for: .normal)
  }
}
