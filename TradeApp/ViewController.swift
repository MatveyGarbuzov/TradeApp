//
//  ViewController.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
  
  lazy var button: UIButton = {
    let button = UIButton()
    button.backgroundColor = .red
    button.setTitle("Press", for: .normal)
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    
    return button
  }()
  
//  private let numericTimeTextField = NumericTimeTextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    
    view.addSubview(button)
//    view.addSubview(numericTimeTextField)
    
    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(60)
      make.width.equalTo(200)
    }
//    numericTimeTextField.snp.makeConstraints { make in
//      make.centerX.equalToSuperview()
//      make.top.equalTo(button.snp.bottom).offset(20)
//      make.height.equalTo(50)
//      make.width.equalToSuperview().multipliedBy(0.6)
//    }
    
    setupKeyboard()
  }
  
  private func setupKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc func buttonPressed(_ sender: UIView) {
    print("Pressed!")
  }
}
