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
  let navLabel = UILabel()
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
    setupKeyboard()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
    setupLoadingView()
    updateView()
  }
  
  private func setupKeyboard() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector:      #selector(handleKeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc private func handleKeyboardWillShow(notification: Notification) {
    guard let keyboardFrame = getKeyboardFrame(from: notification.userInfo) else { return }
    let offset = keyboardFrame.height
    actionStack.snp.updateConstraints { make in
      make.bottom.equalToSuperview().inset(offset)
    }
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
      self.actionStack.backgroundColor = UIColor.Theme.actionStackBG
    })
  }
  
  @objc private func handleKeyboardWillHide(notification: Notification) {
    let screenHeight = view.bounds.size.height * 0.09
    actionStack.snp.updateConstraints { make in
      make.bottom.equalTo(view.safeAreaInsets.bottom).offset(-screenHeight)
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
      self.actionStack.backgroundColor = .clear
    })
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  // MARK: - Helper
  private func getKeyboardFrame(from userInfo: [AnyHashable : Any]?) -> CGRect? {
    guard let userInfo = userInfo else { return nil }
    guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
    return self.view.convert(keyboardFrame, from: nil)
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
      make.top.equalTo(balanceLabel.snp.bottom).offset(20)
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
    
    // Calculate stackHeight to correctly fit the screen
    let balanceLabelHeight = 57.0
    let webViewHeight = view.bounds.size.width * 0.85
    let screenHeight = view.bounds.size.height
    let stackHeight = (screenHeight * 0.8 - balanceLabelHeight - webViewHeight) * 0.85
    
    actionStack.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaInsets.bottom).offset(-screenHeight*0.09)
      make.height.equalTo(stackHeight)
      make.centerX.equalToSuperview()
      make.width.equalToSuperview()
    }
  }
  
  func updateView() {
//    guard let viewModel = viewModel else { return }
    
    webView.load(request)
    balanceLabel.viewModel = viewModel
    actionStack.viewModel = viewModel
    actionStack.delegate = self
    actionStack.currencyDelegate = self
  }
  
  func viewIsReady() {
    tabBarController?.tabBar.isHidden = false
    navigationItem.titleView = navLabel
    navLabel.textColor = UIColor.Theme.text
    navLabel.font = UIFont.appFontBold(ofSize: 20)
    navLabel.text = viewModel.title
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

extension TradeViewController: CurrencyPairDelegate {
  func chooseCurrency() {
    let currencyPairVC = CurrencyPairViewController()
    currencyPairVC.delegate = self
    currencyPairVC.tradeModel = viewModel
    navigationController?.pushViewController(currencyPairVC, animated: true)
  }
}

extension TradeViewController: UpdateViewModel {
  func updateViewModel() {
    actionStack.updateCurrencyPair()
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
    viewIsReady()
  }
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//    let progress = webView.estimatedProgress
//    loadingView?.setProgress(progress: Float(progress))
    loadingView?.animateLoading() // Smooth animation
  }
}
