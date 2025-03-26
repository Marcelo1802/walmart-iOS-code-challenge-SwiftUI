import Foundation

struct Country: Codable, Identifiable {
    let name: String
    let region: String
    let code: String
    let capital: String
    
    var id: String { code }
} 