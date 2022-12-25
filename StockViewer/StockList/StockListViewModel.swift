//
//  StockListViewModel.swift
//  StockViewer
//
//  Created by ali rahal on 24/12/2022.
//

import Foundation

protocol StockListDelegate: NSObject {
    func updateTableView()
}
class StockListViewModel {
    
    //MARK: Properties
    let stocks: [Stock] = Stock.demoStocks
    let stockPriceService = StockPriceUpdateService()
    weak var delegate: StockListDelegate?
    
    //MARK: Data Fetching
    func updateStockPrices() {
        for stock in stocks {
            stockPriceService.subscribe(stockId: stock.stockId) { [weak self] priceUpdate in
                let price = (priceUpdate.currentPrice as NSDecimalNumber).doubleValue
                stock.price = price
                self?.delegate?.updateTableView()
            }
        }
    }
    
    func getCellInfo(index: IndexPath) -> Stock {
        return stocks[index.row]
    }
    
    deinit {
        print(self)
    }
}
