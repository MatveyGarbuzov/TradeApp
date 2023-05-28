//
//  TopTraderViewModel.swift
//  TradeApp
//
//  Created by Matvey Garbuzov on 27.05.2023.
//

import UIKit

struct TopTrader {
  let number: Int
  let country: String
  let name: String
  let deposit: String
  let profit: String
  
  let height: CGFloat = 55.0
  var flag: UIImageView {
    return UIImageView(image: UIImage(named: country) ?? UIImage(named: "USA")!)
  }
}

class TopTraderViewModel {
  var title = "TOP 10 Traders"
  var traders: [TopTrader] = []
  
  init() {
    let trader1 = TopTrader(number: 1, country: "USA", name: "Oliver", deposit: "$2367", profit: "$336755")
    let trader2 = TopTrader(number: 2, country: "Canada", name: "Jack", deposit: "$1175", profit: "$148389")
    let trader3 = TopTrader(number: 3, country: "Brazil", name: "Harry", deposit: "$1000", profit: "$113888")
    let trader4 = TopTrader(number: 4, country: "South-Korea", name: "Jacob", deposit: "$999", profit: "$36755")
    let trader5 = TopTrader(number: 5, country: "Germany", name: "Charley", deposit: "$888", profit: "$18389")
    let trader6 = TopTrader(number: 6, country: "Brazil", name: "Thomas", deposit: "$777", profit: "$12000")
    let trader7 = TopTrader(number: 7, country: "France", name: "George", deposit: "$666", profit: "$11111")
    let trader8 = TopTrader(number: 8, country: "New-Zealand", name: "Oscar", deposit: "$555", profit: "$9988")
    let trader9 = TopTrader(number: 9, country: "India", name: "James", deposit: "$444", profit: "$8877")
    let trader10 = TopTrader(number: 10, country: "Spain", name: "William", deposit: "$333", profit: "$6652")
    
    traders = [trader1, trader2, trader3, trader4, trader5, trader6, trader7, trader8, trader9, trader10]
  }
  
  func getCellModel(at indexPath: IndexPath) -> TopTraderCellModel {
    let trader = traders[indexPath.row]
    let cellModel = TopTraderCellModel(number: trader.number, country: trader.flag, name: trader.name, deposit: trader.deposit, profit: trader.profit)
    return cellModel
  }
  
  func getNumberOfRows() -> Int {
    return traders.count
  }
  
  func getHeight() -> CGFloat {
    return traders[0].height
  }
}

