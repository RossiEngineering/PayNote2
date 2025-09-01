import SwiftUI

struct InstitutionDetailView: View {
    @ObservedObject var viewModel: InstitutionViewModel
    var institution: Institution
    
    @State private var title = ""
    @State private var menu = ""
    @State private var amount = ""
    @State private var editingTransaction: Transaction?
    
    var body: some View {
        VStack {
            Text("잔액: \(institution.balance)원")
                .font(.largeTitle)
                .padding()
            
            Form {
                Section(header: Text("내역 추가")) {
                    TextField("이름", text: $title)
                    TextField("메뉴", text: $menu)
                    TextField("금액", text: $amount)
                        .keyboardType(.numberPad)
                    
                    HStack {
                        Button("차감") {
                            if let amt = Int(amount) {
                                let tx = Transaction(title: title, menu: menu, amount: amt)
                                viewModel.addTransaction(to: institution, transaction: tx, isAdd: false)
                                resetFields()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        
                        Button("추가") {
                            if let amt = Int(amount) {
                                let tx = Transaction(title: title, menu: menu, amount: amt)
                                viewModel.addTransaction(to: institution, transaction: tx, isAdd: true)
                                resetFields()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
                
                Section(header: Text("내역")) {
                    List {
                        ForEach(institution.transactions) { trans in
                            VStack(alignment: .leading) {
                                Text("\(trans.title) - \(trans.menu)")
                                    .font(.headline)
                                HStack {
                                    Text("\(trans.amount)원").bold()
                                    Spacer()
                                    Text(trans.date, style: .date)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .onTapGesture {
                                editingTransaction = trans
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let trans = institution.transactions[index]
                                viewModel.deleteTransaction(in: institution, transaction: trans)
                            }
                        }
                    }
                }
            }
        }
        .sheet(item: $editingTransaction) { tx in
            TransactionEditView(viewModel: viewModel, institution: institution, transaction: tx)
        }
    }
    
    private func resetFields() {
        title = ""
        menu = ""
        amount = ""
    }
}
