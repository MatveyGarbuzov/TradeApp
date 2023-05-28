//
//  CurrencyPairViewController.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 26.05.2023.
//

import UIKit

protocol UpdateViewModel: AnyObject {
  func updateViewModel()
}

class CurrencyPairViewController: UIViewController {
  weak var delegate: UpdateViewModel?
  weak var tradeModel: TradeViewModel?
  
  let navLabel = UILabel()
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  let viewModel = CollectionViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.Theme.bg
    
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
    
    setupNavBar()
    setupConstraints()
  }
  
  private func setupNavBar() {
    navigationItem.titleView = navLabel
    navLabel.textColor = UIColor.Theme.text
    navLabel.font = UIFont.appFontBold(ofSize: 20)
    navLabel.text = viewModel.title
    navigationController?.navigationBar.topItem?.backButtonTitle = ""
    navigationController?.navigationBar.tintColor = UIColor.Theme.text
  }
  
  private func setupConstraints() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
      make.center.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.9)
    }
  }
}

extension CurrencyPairViewController: CollectionButtonDelegate {
  func popView(with currencyPair: String) {
    
    tradeModel?.currencyPair = currencyPair
    delegate?.updateViewModel()
    navigationController?.popViewController(animated: true)
  }
}

extension CurrencyPairViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
//    cell.button.setTitle(viewModel.items[indexPath.item], for: .normal)
//    cell.title = viewModel.items[indexPath.item]
//    cell.setupCell(with: viewModel.items[indexPath.item])
    cell.updatetitle(viewModel.items[indexPath.item])
    
    cell.delegate = self
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthPerItem = collectionView.frame.width / 2 - 10
    return CGSize(width: widthPerItem, height: 60)
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}
