import Foundation

@MainActor
class CountryViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var filteredCountries: [Country] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var error: String?
    
    private let service = CountryService.shared
    
    func fetchCountries() {
        isLoading = true
        error = nil
        
        Task {
            do {
                countries = try await service.fetchCountries()
                filteredCountries = countries
                isLoading = false
            } catch let networkError as NetworkError {
                self.error = networkError.localizedDescription
                isLoading = false
            } catch {
                self.error = "Erro inesperado: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
    
    func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = countries
            return
        }
        
        filteredCountries = countries.filter { country in
            country.name.localizedCaseInsensitiveContains(searchText) ||
            country.capital.localizedCaseInsensitiveContains(searchText)
        }
    }
} 