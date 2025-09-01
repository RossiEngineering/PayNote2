import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = InstitutionViewModel()
    @State private var showingAddInstitution = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.institutions) { inst in
                    NavigationLink(destination: InstitutionDetailView(viewModel: viewModel, institution: inst)) {
                        HStack {
                            Text(inst.name)
                                .font(.headline)
                            Spacer()
                            Text("잔액: \(inst.balance)원")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("선결제 기관")
            .toolbar {
                Button(action: { showingAddInstitution = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddInstitution) {
                AddInstitutionView(viewModel: viewModel, isPresented: $showingAddInstitution)
            }
        }
    }
}
