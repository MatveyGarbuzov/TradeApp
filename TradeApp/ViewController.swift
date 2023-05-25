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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(60)
      make.width.equalTo(200)
    }
  }
  
  @objc func buttonPressed(_ sender: UIView) {
    print("Pressed!")
  }
}
