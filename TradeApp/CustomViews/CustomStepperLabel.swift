//
//  CustomStepperLabel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

protocol StepperDelegate: AnyObject {
  func leftButtonTapped(sender: StepperLabel)
  func rightButtonTapped(sender: StepperLabel)
  func update(sender: StepperLabel)
}

class StepperLabel: CustomLabel {
  weak var stepperDelegate: StepperDelegate?
  var viewModel: TradeViewModel? {
    didSet {
      updateUI()
    }
  }
  
  let textField: CustomUITextField = {
    let textField = CustomUITextField()
    textField.font = UIFont.appFontBold(ofSize: 16)
    textField.textAlignment = .center
    textField.textColor = UIColor.Theme.additionalText
    textField.backgroundColor = .clear//UIColor.Theme.additionalBG
    textField.textColor = .clear
    textField.keyboardType = .numberPad
    
    return textField
  }()
  
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
    textField.delegate = self
    
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
    super.addSubview(textField)
    
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
    
    textField.snp.makeConstraints { make in
      make.edges.equalTo(super.label).inset(5)
    }
  }
  
  @objc private func leftButtonTapped() {
    stepperDelegate?.leftButtonTapped(sender: self)
  }

  @objc private func rightButtonTapped() {
    stepperDelegate?.rightButtonTapped(sender: self)
  }
  
  func updateUI() {
    stepperDelegate?.update(sender: self)
  }
}

// Disable paste action
class CustomUITextField: UITextField {
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(UIResponderStandardEditActions.paste(_:)) {
      return false
    }
    return super.canPerformAction(action, withSender: sender)
  }
}

extension StepperLabel: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    print("Началось редактирование")
    self.textField.show()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.textField.hide()
    updateUI()
  }
}

extension CustomUITextField {
  func show() {
    UIView.animate(withDuration: 0.3, delay: 0) {
      self.alpha = 1
      self.textColor = UIColor.Theme.additionalText
      self.backgroundColor = UIColor.Theme.additionalBG
      self.placeholder = "00:00"
    }
  }
  
  func hide() {
    UIView.animate(withDuration: 0.3, delay: 0) {
      self.backgroundColor = .clear
      self.textColor = .clear
      self.placeholder = ""
    }
  }
}
