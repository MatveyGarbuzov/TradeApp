//
//  TradeViewController.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import UIKit
import WebKit
import SnapKit


class TradeViewController: UIViewController {
//  var viewModel: TradeViewModel?
  let request = URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!))
  var viewModel = TradeViewModel(trade: TradeModel(amount: 100, timer: 10), url: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!))

  let balanceStack = CustomBalanceStack()
  
  let webView: WKWebView = {
    let view = WKWebView()
    
//    view.load(request)
//    view.backgroundColor = .orange
    view.isOpaque = false;
    view.backgroundColor = .clear
    view.scrollView.isScrollEnabled = false
    
    return view
  }()
  
  let amountLabel = UILabel()
  let timerLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.Theme.bg
    self.webView.scrollView.delegate = self
    
    updateView()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateView()
    title = "Trade"
    self.navigationController?.navigationBar.titleTextAttributes =
    [NSAttributedString.Key.foregroundColor: UIColor.white,
     NSAttributedString.Key.font: UIFont.appFontBold(ofSize: 20)]
  }
  
  func setupConstraints() {
    view.addSubview(balanceStack)
    view.addSubview(webView)
    
    
    balanceStack.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.9)
      make.height.equalTo(57)
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide)
    }
    
    webView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(balanceStack.snp.bottom).offset(33)
      make.width.height.equalTo(view.snp.width).offset(10)
    }
  }
  
  func updateView() {
//    guard let viewModel = viewModel else { return }
    
    webView.load(request)
    amountLabel.text = viewModel.amountString
    timerLabel.text = viewModel.timerString
    balanceStack.setBalanceAmount(10000)
  }
}


// Disable scroll in WKWebView
extension TradeViewController: UIScrollViewDelegate {
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    scrollView.pinchGestureRecognizer?.isEnabled = false
  }
}
