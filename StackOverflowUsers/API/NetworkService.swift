import Foundation

struct UserResponse: Codable {
    let items: [User]
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        case .serverError(let statusCode):
            return "Server error: \(statusCode)"
        }
    }
}

protocol NetworkServiceProtocol {
    func fetchUsers() async throws -> [User]
}

class NetworkService: NetworkServiceProtocol {
    func fetchUsers() async throws -> [User] {
        let urlString = "https://api.stackexchange.com/2.2/users?page=1&pagesize=20&order=desc&sort=reputation&site=stackoverflow"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            return userResponse.items
        } catch {
            throw NetworkError.decodingError
        }
    }
}

