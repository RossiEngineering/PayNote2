import Foundation

struct Transaction: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var menu: String
    var amount: Int
    var date: Date
    
    init(id: UUID = UUID(), title: String, menu: String, amount: Int, date: Date = Date()) {
        self.id = id
        self.title = title
        self.menu = menu
        self.amount = amount
        self.date = date
    }
}
