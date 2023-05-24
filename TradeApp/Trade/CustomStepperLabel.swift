//
//  CustomStepperLabel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
  func leftButtonTapped(sender: StepperLabel)
  func rightButtonTapped(sender: StepperLabel)
}


class StepperLabel: CustomLabel {
  weak var delegate: CustomButtonDelegate?
  
  let leftStepper = CustomStepper()
  let rightStepper = CustomStepper()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    leftStepper.setImage(UIImage(systemName: "minus.circle")!)
    leftStepper.buttonActionHandler = { _ in
      self.leftButtonTapped()
    }
    
    rightStepper.setImage(UIImage(systemName: "plus.circle")!)
    rightStepper.buttonActionHandler = { _ in
      self.rightButtonTapped()
    }
    
    super.addSubview(leftStepper)
    super.addSubview(rightStepper)
    
    leftStepper.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(15)
      make.right.equalTo(super.label.snp.left).offset(10)
      make.height.equalTo(super.label.snp.height)
      make.bottom.equalTo(super.label.snp.bottom)
    }
    
    rightStepper.snp.makeConstraints { make in
      make.right.equalToSuperview().offset(-15)
      make.left.equalTo(super.label.snp.right).offset(-10)
      make.height.equalTo(super.label.snp.height)
      make.bottom.equalTo(super.label.snp.bottom)
    }
  }
  
  @objc private func leftButtonTapped() {
    print("left")
    delegate?.leftButtonTapped(sender: self)
  }

  @objc private func rightButtonTapped() {
    print("right")
    delegate?.rightButtonTapped(sender: self)
  }

}
