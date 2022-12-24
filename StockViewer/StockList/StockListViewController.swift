import UIKit

final class StockListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let stocks: [Stock] = Stock.demoStocks

    var prices: [(stockId: String, price: Double)] = []

    let stockPriceService = StockPriceUpdateService()

    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Stocks"

        for stock in stocks {
            stockPriceService.subscribe(stockId: stock.stockId) { priceUpdate in
                let price = (priceUpdate.currentPrice as NSDecimalNumber).doubleValue
                if let index = self.prices.firstIndex(where: { $0.stockId == stock.stockId }) {
                    self.prices[index] = (stock.stockId, price)
                } else {
                    self.prices.append((stock.stockId, price))
                }
                self.tableView.reloadData()
            }
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockListCell.self, forCellReuseIdentifier: "StockListCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockListCell", for: indexPath)
        guard let stockListCell = cell as? StockListCell else {
            return cell
        }
        stockListCell.nameLabel.text = stocks[indexPath.row].name
        let price = prices.first(where: { $0.stockId == stocks[indexPath.row].stockId })?.price ?? 0.0
        let formattedPrice = String(format: "%.2f €", price)
        stockListCell.priceLabel.text = formattedPrice
        return stockListCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #if DEBUG
        print("selected", indexPath)
        #endif
    }
}
