//
//  Animations.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit

extension UIView {
  func animateOutsidePress() {
    UIView.animate(withDuration: 0.15, animations: {
      self.transform = self.transform.scaledBy(x: 1.05, y: 1.05)
    }) { _ in
      UIView.animate(withDuration: 0.15, animations: {
        self.transform = CGAffineTransform.identity
      })
    }
  }
  
  func animateOutsidePress(withInDuration inDuration: TimeInterval = 0.2,
                           withOutDuration outDuration: TimeInterval = 0.2,
                           scaledByX x: CGFloat = 1.1,
                           scaledByY y: CGFloat = 1.1) {
    UIView.animate(withDuration: inDuration, animations: {
      self.transform = self.transform.scaledBy(x: x, y: y)
    }) { _ in
      UIView.animate(withDuration: outDuration, animations: {
        self.transform = CGAffineTransform.identity
      })
    }
  }
  
  func animateInsidePress() {
    UIView.animate(withDuration: 0.15, animations: {
      self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
    }) { _ in
      UIView.animate(withDuration: 0.15, animations: {
        self.transform = CGAffineTransform.identity
      })
    }
  }
  
  func animateInsidePress(withInDuration inDuration: TimeInterval = 0.2,
                           withOutDuration outDuration: TimeInterval = 0.2,
                          scaledByX x: CGFloat = 0.9,
                          scaledByY y: CGFloat = 0.9) {
    UIView.animate(withDuration: inDuration, animations: {
      self.transform = self.transform.scaledBy(x: x, y: y)
    }) { _ in
      UIView.animate(withDuration: outDuration, animations: {
        self.transform = CGAffineTransform.identity
      })
    }
  }
  
  func shake() {
      let animation = CABasicAnimation(keyPath: "position")
      animation.duration = 0.1
      animation.repeatCount = 1
      animation.autoreverses = true
      animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
      animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
      self.layer.add(animation, forKey: "position")
    }

}
