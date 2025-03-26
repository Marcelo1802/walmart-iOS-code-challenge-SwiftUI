import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .invalidResponse:
            return "Resposta inválida do servidor"
        case .decodingError:
            return "Erro ao processar os dados recebidos"
        case .serverError(let message):
            return "Erro do servidor: \(message)"
        }
    }
}

class CountryService {
    static let shared = CountryService()
    private let baseURL = "https://restcountries.com/v3.1/all"
    
    private init() {}
    
    func fetchCountries() async throws -> [Country] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                throw NetworkError.serverError("Status code: \(httpResponse.statusCode)")
            }
            
            do {
                let countries = try JSONDecoder().decode([RestCountry].self, from: data)
                return countries.map { restCountry in
                    Country(
                        name: restCountry.name.common,
                        region: restCountry.region,
                        code: restCountry.cca2,
                        capital: restCountry.capital?.first ?? "N/A"
                    )
                }
            } catch {
                print("Erro de decodificação: \(error)")
                throw NetworkError.decodingError
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.serverError(error.localizedDescription)
        }
    }
}

// Estrutura para decodificar a resposta da API REST Countries
struct RestCountry: Codable {
    let name: CountryName
    let region: String
    let cca2: String
    let capital: [String]?
    
    struct CountryName: Codable {
        let common: String
    }
} 