//
//  TradeViewController.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 23.05.2023.
//

import UIKit
import WebKit
import SnapKit
import Alamofire

class TradeViewController: UIViewController {
  //  var viewModel: TradeViewModel?
  private var loadingView: LoadingView?
  
  let request = URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!))
  let viewModel = TradeViewModel()
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
    setupConstraints()
    setupView()
    setupNavBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupLoadingView()
    updateView()
    title = "Trade"
  }
  
  func setupNavBar() {
    self.navigationController?.navigationBar.titleTextAttributes =
    [NSAttributedString.Key.foregroundColor: UIColor.white,
     NSAttributedString.Key.font: UIFont.appFontBold(ofSize: 20)]
  }
  
  func setupView() {
    view.backgroundColor = UIColor.Theme.bg
    self.webView.scrollView.delegate = self
  }
  
  func hasInternetConnection() -> Bool {
    let manager = NetworkReachabilityManager()
    return manager?.isReachable ?? false
  }
  
  func setupLoadingView() {
    webView.navigationDelegate = self
    loadingView = LoadingView(frame: view.bounds)
    view.addSubview(loadingView!)
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
    
    if hasInternetConnection() == false {
      let connectionErrorLabel = ConnectionErrorLabel()
      webView.addSubview(connectionErrorLabel)
      connectionErrorLabel.snp.makeConstraints { make in
        make.edges.equalToSuperview()
      }
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
    balanceLabel.viewModel = viewModel
    actionStack.viewModel = viewModel
    actionStack.delegate = self
  }
}


// Disable scroll in WKWebView
extension TradeViewController: UIScrollViewDelegate {
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    scrollView.pinchGestureRecognizer?.isEnabled = false
  }
}

extension TradeViewController: BalanceChangedDelegate {
  func updateBalanceLabel() {
    balanceLabel.updateUI()
  }
}

extension TradeViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    loadingView?.setWebView(webView: webView)
    view.addSubview(loadingView!)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    loadingView?.removeFromSuperview()
    loadingView = nil
  }
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//    let progress = webView.estimatedProgress
//    loadingView?.setProgress(progress: Float(progress))
    loadingView?.animateLoading() // Smooth animation
  }
}
