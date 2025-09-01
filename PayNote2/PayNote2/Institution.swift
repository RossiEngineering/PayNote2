import Foundation

struct Institution: Identifiable, Codable {
    let id: UUID
    var name: String
    var balance: Int
    var transactions: [Transaction]
    
    init(id: UUID = UUID(), name: String, balance: Int, transactions: [Transaction] = []) {
        self.id = id
        self.name = name
        self.balance = balance
        self.transactions = transactions
    }
}
