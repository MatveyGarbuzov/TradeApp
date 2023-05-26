//
//  LoadingView.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 24.05.2023.
//

import UIKit
import WebKit

class LoadingView: UIView {
  var webView: WKWebView?
  private var webViewObservation: NSKeyValueObservation?
  
  private let blurView: UIView = {
    let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    
    return blurView
  }()
  
  private let loadingLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.white
    label.text = "0%"
    label.textAlignment = .center
    label.font = UIFont.appFontExtraBold(ofSize: 16)
    
    return label
  }()
  
  private let greenSquare: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.Theme.green
    return view
  }()
  
  private let redSquare: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.Theme.red
    return view
  }()
  
  private let progressView: UIProgressView = {
    let progressView = UIProgressView()
    progressView.backgroundColor = UIColor.Theme.loadingBG
    progressView.layer.cornerRadius = 9
    progressView.progressTintColor = UIColor.Theme.green
    progressView.clipsToBounds = true
    
    return progressView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    setupObservers()
    addAnimation()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    backgroundColor = UIColor.Theme.bg
    
    addSubview(greenSquare)
    addSubview(redSquare)
    addSubview(blurView)
    addSubview(progressView)
    progressView.addSubview(loadingLabel)
    
    greenSquare.snp.makeConstraints { make in
      make.width.equalTo(70)
      make.height.equalTo(300)
      make.bottom.equalToSuperview().offset(-20)
      make.right.equalToSuperview().offset(-20)
    }
    
    redSquare.snp.makeConstraints { make in
      make.width.equalTo(70)
      make.height.equalTo(150)
      make.bottom.equalToSuperview().offset(-50)
      make.left.equalToSuperview().offset(20)
    }
    
    blurView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    progressView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-20)
      make.height.equalTo(20)
      make.width.equalToSuperview().multipliedBy(0.9)
    }
    
    loadingLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func addAnimation() {
    UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: { [self] in
      redSquare.frame.origin.y += 50
    }, completion: nil)
    
    UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: { [self] in
      greenSquare.frame.origin.y -= 50
    }, completion: nil)
  }
  
  private func setupObservers() {
    webViewObservation = webView?.observe(\.estimatedProgress, options: [.new]) { [weak self] _, change in
      if let progress = change.newValue {
        self?.progressView.progress = Float(progress)
      }
    }
  }
  
  func setWebView(webView: WKWebView) {
    self.webView = webView
  }
  
  // Real loading
  func setProgress(progress: Float) {
    self.progressView.progress = progress
    self.loadingLabel.text = "\(Int(progress*100))%"
  }
  
  // Smooth loading
  func animateLoading() {
    let isLoading = true
    var progress: Float = 0.0
    
    // Start the progress timer
    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
      if isLoading {
        progress += 0.01
        self.setProgress(progress: progress)
        
        // Stop timer once progress is complete
        if progress >= 1.0 {
          timer.invalidate()
        }
      } else {
        timer.invalidate()
      }
    }
    
    //    // Animate the progress view
    //    UIView.animate(withDuration: duration, animations: {
    //      self.progressView.setProgress(1.0, animated: true)
    //    }) { finished in
    //      // Reset the progress view and progress variable
    //      self.setProgress(progress: 0.0)
    //      self.progressView.setProgress(0.0, animated: false)
    //    }
  }
}

extension LoadingView: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    let progress = Float(webView.estimatedProgress)
    
    // Update the progress view based on estimatedProgress
    setProgress(progress: progress)
    animateLoading()
  }
}
