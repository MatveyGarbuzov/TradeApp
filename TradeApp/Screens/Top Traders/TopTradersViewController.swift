//
//  TopTradersViewController.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 27.05.2023.
//

import UIKit
import SnapKit

class TopTradersViewController: UIViewController {
  
  private let navLabel = UILabel()
  private let numberLabel = UILabel()
  private let countryLabel = UILabel()
  private let nameLabel = UILabel()
  private let depositLabel = UILabel()
  private let profitLabel = UILabel()
  private let spacer = UIView()
  
  private let tableViewTop: UIStackView = {
    let stack = UIStackView()
    stack.backgroundColor = UIColor.Theme.additionalBG
    stack.axis = .horizontal
    stack.distribution = .equalSpacing
    stack.spacing = 0
    stack.layer.cornerRadius = 12
    stack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    return stack
  }()
  private let tableView = UITableView()
  private let viewModel = TopTraderViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupTableView()
    setupTableViewTop()
    setupLayout()
  }
  
  private func setupNavBar() {
    navigationItem.titleView = navLabel
    navLabel.textColor = UIColor.Theme.text
    navLabel.font = UIFont.appFontBold(ofSize: 20)
    navLabel.text = viewModel.title
  }
  
  private func setupTableViewTop() {
    tableViewTop.addArrangedSubview(numberLabel)
    tableViewTop.addArrangedSubview(countryLabel)
    tableViewTop.addArrangedSubview(nameLabel)
    tableViewTop.addArrangedSubview(depositLabel)
    tableViewTop.addArrangedSubview(profitLabel)
    tableViewTop.addArrangedSubview(spacer)
    
    numberLabel.setup(title: "№")
    countryLabel.setup(title: "Country")
    nameLabel.setup(title: "Name")
    depositLabel.setup(title: "Deposit")
    profitLabel.setup(title: "Profit")
    
    depositLabel.textAlignment = .right
    profitLabel.textAlignment = .right
  }
  
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.backgroundColor = UIColor.Theme.bg
    tableView.layer.cornerRadius = 12
    tableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.register(TopTraderCell.self, forCellReuseIdentifier: "TopTraderCell")
  }
  
  private func setupLayout() {
    view.backgroundColor = UIColor.Theme.bg
    view.addSubview(tableViewTop)
    view.addSubview(tableView)
    
    let count = CGFloat(viewModel.getNumberOfRows())
    let height = viewModel.getHeight()
    
    tableViewTop.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
      make.leading.right.equalToSuperview().inset(10)
      make.height.equalTo(55)
    }
    
    numberLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.top.bottom.equalToSuperview().inset(10)
      make.width.equalToSuperview().multipliedBy(0.05)
    }
    
    countryLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalTo(numberLabel.snp.trailing).offset(10)
      make.width.equalToSuperview().multipliedBy(0.17)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalTo(countryLabel.snp.trailing).offset(10)
      make.width.equalToSuperview().multipliedBy(0.19)
    }
    
    depositLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.trailing.equalTo(profitLabel.snp.leading).offset(-20)
      make.width.equalToSuperview().multipliedBy(0.2)
    }
    
    profitLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.trailing.equalToSuperview().inset(10)
      make.width.equalToSuperview().multipliedBy(0.15)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(tableViewTop.snp.bottom)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(count*height)
    }
  }
  
}

extension UILabel {
  func setup(title: String) {
    self.text = title
    self.textColor = UIColor.Theme.additionalText
    self.font = UIFont.appFontMedium(ofSize: 12)
    self.textAlignment = .left
  }
}

extension TopTradersViewController: UITableViewDelegate {}

extension TopTradersViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getNumberOfRows()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    viewModel.getHeight()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopTraderCell", for: indexPath) as! TopTraderCell
    let cellModel = viewModel.getCellModel(at: indexPath)
    cell.model = cellModel
    if indexPath.row % 2 == 0 {
      cell.backgroundColor = UIColor.Theme.bg
    } else {
      cell.backgroundColor = UIColor.Theme.additionalBG
    }
    return cell
  }
  
}
