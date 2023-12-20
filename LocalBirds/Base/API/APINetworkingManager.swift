//
//  NetworkingManager.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class APINetworkingManager { //class must be final to eliminate children
    private let keypair: APIKeyPair
    
    //singleton (anti-pattern): private initialiser (cannot be instantiated outside of class definition) and shared static instance
    static let shared = APINetworkingManager(kp: PrivateConstants.APIConstants.keyPair)
    private init(kp: APIKeyPair) {keypair = kp}
    
    func request<T: Codable>(_ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        
        //build request
        guard let url = endpoint.url else { throw NetworkingError.invalidURL }
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        //await data and response from URLSession request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        //handle responses outside of success range
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else { //pattern match to response status codes
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        //decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(T.self, from: data)
        
        return result
    }
    
    func request(_ endpoint: Endpoint) async throws {
        
        //build request
        guard let url = endpoint.url else { throw NetworkingError.invalidURL }
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        //await data and response from URLSession request
        let (_, response) = try await URLSession.shared.data(for: request)
        
        //handle responses outside of success range
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else { //pattern match to response status codes
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}

extension APINetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case faledToDecode(error: Error)
    }
}

extension APINetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL isn't valid"
        case .invalidStatusCode(let code):
            return "Status code (\(code)) is not in range"
        case .invalidData:
            return "Response data is invalid"
        case .faledToDecode(let err):
            return "Failed to decode: \(err.localizedDescription)"
        case .custom(let err):
            return "Something went wrong: \(err.localizedDescription)"
        }
    }
}

private extension APINetworkingManager {
    func buildRequest(from url: URL,
                      methodType: Endpoint.MethodType) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(keypair.value, forHTTPHeaderField: keypair.key) // optional: use with APIs that need keys
        
        return request
    }
}
