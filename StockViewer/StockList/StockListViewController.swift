import UIKit

final class StockListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StockListDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
    

    //MARK: Outlets
    private var tableView = UITableView()
    var viewModel: StockListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Stocks"
        setupTableView()
        self.viewModel?.updateStockPrices()
        self.viewModel?.delegate = self
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockListCell.self, forCellReuseIdentifier: "StockListCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.stocks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockListCell", for: indexPath)
        guard let stockListCell = cell as? StockListCell else {
            return cell
        }
        guard let stock = self.viewModel?.getCellInfo(index: indexPath) else { return UITableViewCell() }
        stockListCell.nameLabel.text = stock.name
        stockListCell.priceLabel.text = formattedPrice
        return stockListCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #if DEBUG
        print("selected", indexPath)
        #endif
    }
}
