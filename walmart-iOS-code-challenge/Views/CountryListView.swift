import SwiftUI

struct CountryListView: View {
    @StateObject private var viewModel = CountryViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Carregando países...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.error {
                    VStack(spacing: 20) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                        
                        Text("Erro ao carregar dados")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(error)
                            .font(.body)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.fetchCountries()
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("Tentar Novamente")
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                } else {
                    List(viewModel.filteredCountries) { country in
                        CountryRow(country: country)
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Buscar por nome ou capital")
                    .onChange(of: viewModel.searchText) { _ in
                        viewModel.filterCountries()
                    }
                }
            }
            .navigationTitle("Países")
            .onAppear {
                viewModel.fetchCountries()
            }
        }
    }
}

struct CountryRow: View {
    let country: Country
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(country.name)
                .font(.headline)
            HStack {
                Text("Região: \(country.region)")
                Spacer()
                Text("Código: \(country.code)")
            }
            .font(.subheadline)
            Text("Capital: \(country.capital)")
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CountryListView()
} 