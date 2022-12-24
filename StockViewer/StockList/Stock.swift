import Foundation

class Stock: NSObject {
    var stockId: String
    var name: String

    init(stockId: String, name: String) {
        self.stockId = stockId
        self.name = name
    }
}

extension Stock {
    static let demoStocks: [Stock] =  [
        Stock(stockId: "US0378331005", name: "Apple"),
        Stock(stockId: "US88160R1014", name: "Tesla"),
        Stock(stockId: "US5949181045", name: "Microsoft")
    ]
}
