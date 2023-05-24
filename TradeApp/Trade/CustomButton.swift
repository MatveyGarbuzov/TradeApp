//
//  CustomButton.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

class PaddingLabel: UILabel {
  
  var topInset: CGFloat = 5.0
  var bottomInset: CGFloat = 5.0
  var leftInset: CGFloat = 7.0
  var rightInset: CGFloat = 7.0
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
  }
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset,
                  height: size.height + topInset + bottomInset)
  }
  
  override var bounds: CGRect {
    didSet {
      // ensures this works within stack views if multi-line
      preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
    }
  }
}

class CustomButton: UIButton {
  private let customLabel: PaddingLabel = {
    let label = PaddingLabel()
    label.textColor = UIColor.Theme.text
    label.font = UIFont.appFontMedium(ofSize: 24)
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCustomLabel()
    
    layer.cornerRadius = 12
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupCustomLabel()
  }
  
  private func setupCustomLabel() {
    addSubview(customLabel)
    customLabel.topInset = 8
    customLabel.leftInset = 20
    customLabel.bottomInset = 17
    
    customLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func set(text: String) {
    self.customLabel.text = text
  }
}

