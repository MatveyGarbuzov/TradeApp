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
  let viewModel = TradeViewModel()
//  var viewModel = TradeViewModel(trade: TradeModel(amount: 100, timer: 10), url: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!))

  let balanceLabel = BalanceLabel()
  
  let webView: WKWebView = {
    let view = WKWebView()
    view.isOpaque = false;
    view.backgroundColor = .clear
    view.scrollView.isScrollEnabled = false
    
    return view
  }()
  
  let actionStack = CustomActionsStack()

  
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
    view.addSubview(balanceLabel)
    view.addSubview(webView)
    view.addSubview(actionStack)
    
    balanceLabel.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.9)
      make.height.equalTo(57)
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide)
    }
    
    webView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(balanceLabel.snp.bottom).offset(25)
      make.width.equalTo(view.snp.width).offset(10)
      make.height.equalTo(view.snp.width).multipliedBy(0.85)
    }
    
    actionStack.snp.makeConstraints { make in
      make.top.equalTo(webView.snp.bottom).offset(16)
      make.bottom.equalToSuperview()
      make.centerX.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.9)
    }
    
  }
  
  func updateView() {
//    guard let viewModel = viewModel else { return }
    
    webView.load(request)
    balanceLabel.updateLabel(viewModel.balanceText)
    actionStack.viewModel = viewModel
  }
}


// Disable scroll in WKWebView
extension TradeViewController: UIScrollViewDelegate {
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    scrollView.pinchGestureRecognizer?.isEnabled = false
  }
}
