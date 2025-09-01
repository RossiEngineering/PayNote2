import Foundation

class InstitutionViewModel: ObservableObject {
    @Published var institutions: [Institution] = [] {
        didSet {
            saveData()
        }
    }
    
    private let saveKey = "institutions_data"
    
    init() {
        loadData()
    }
    
    func addInstitution(name: String, amount: Int) {
        let new = Institution(name: name, balance: amount)
        institutions.append(new)
    }
    
    func addTransaction(to institution: Institution, transaction: Transaction, isAdd: Bool) {
        if let index = institutions.firstIndex(where: { $0.id == institution.id }) {
            if isAdd {
                institutions[index].balance += transaction.amount
            } else {
                institutions[index].balance -= transaction.amount
            }
            institutions[index].transactions.insert(transaction, at: 0)
        }
    }
    
    func updateTransaction(in institution: Institution, transaction: Transaction, newTransaction: Transaction) {
        if let instIndex = institutions.firstIndex(where: { $0.id == institution.id }) {
            if let txIndex = institutions[instIndex].transactions.firstIndex(where: { $0.id == transaction.id }) {
                
                // 잔액 보정
                let oldAmount = institutions[instIndex].transactions[txIndex].amount
                institutions[instIndex].balance += oldAmount   // 기존 금액 복원
                institutions[instIndex].balance -= newTransaction.amount // 새 금액 반영
                
                institutions[instIndex].transactions[txIndex] = newTransaction
            }
        }
    }
    
    func deleteTransaction(in institution: Institution, transaction: Transaction) {
        if let instIndex = institutions.firstIndex(where: { $0.id == institution.id }) {
            if let txIndex = institutions[instIndex].transactions.firstIndex(where: { $0.id == transaction.id }) {
                // 삭제 시 금액 복원
                institutions[instIndex].balance += institutions[instIndex].transactions[txIndex].amount
                institutions[instIndex].transactions.remove(at: txIndex)
            }
        }
    }
    
    // MARK: - Persistence
    private func saveData() {
        if let data = try? JSONEncoder().encode(institutions) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Institution].self, from: data) {
            institutions = decoded
        }
    }
}
