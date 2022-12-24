import Foundation

class Stock: NSObject {
    var stockId: String
    var name: String
    var price: Double?
    
    init(stockId: String, name: String, price: Double? = nil) {
        self.stockId = stockId
        self.name = name
        self.price = price
    }
    
    let formattedPrice = String(format: "%.2f €", stock.price ?? 0)
}

extension Stock {
    static let demoStocks: [Stock] =  [
        Stock(stockId: "US0378331005", name: "Apple"),
        Stock(stockId: "US88160R1014", name: "Tesla"),
        Stock(stockId: "US5949181045", name: "Microsoft")
    ]
}
