import SwiftUI

struct TransactionEditView: View {
    @ObservedObject var viewModel: InstitutionViewModel
    var institution: Institution
    var transaction: Transaction
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var menu: String
    @State private var amount: String
    @State private var date: Date
    
    init(viewModel: InstitutionViewModel, institution: Institution, transaction: Transaction) {
        self.viewModel = viewModel
        self.institution = institution
        self.transaction = transaction
        _title = State(initialValue: transaction.title)
        _menu = State(initialValue: transaction.menu)
        _amount = State(initialValue: String(transaction.amount))
        _date = State(initialValue: transaction.date)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("이름", text: $title)
                TextField("메뉴", text: $menu)
                TextField("금액", text: $amount)
                    .keyboardType(.numberPad)
                DatePicker("날짜", selection: $date, displayedComponents: [.date])
            }
            .navigationTitle("내역 수정")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        if let amt = Int(amount) {
                            let newTx = Transaction(id: transaction.id, title: title, menu: menu, amount: amt, date: date)
                            viewModel.updateTransaction(in: institution, transaction: transaction, newTransaction: newTx)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { dismiss() }
                }
            }
        }
    }
}
