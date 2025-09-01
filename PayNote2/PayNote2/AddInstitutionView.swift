import SwiftUI

struct AddInstitutionView: View {
    @ObservedObject var viewModel: InstitutionViewModel
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var amount = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("기관 이름", text: $name)
                TextField("선결제 금액", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("기관 추가")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        if let amt = Int(amount) {
                            viewModel.addInstitution(name: name, amount: amt)
                            isPresented = false
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { isPresented = false }
                }
            }
        }
    }
}
