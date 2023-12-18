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
    
    func request<T: Codable>(_ absoluteURL: String, 
                             type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void) {
        
        //build request
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.addValue(keypair.value, forHTTPHeaderField: keypair.key)
        
        //build task to execute request
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            
            //handle returned errors
            if err != nil {
                completion(.failure(NetworkingError.custom(error: err!)))
                return
            }
            
            //handle responses outside of success range
            guard let res = res as? HTTPURLResponse,
                  (200...300) ~= res.statusCode else { //pattern match to response status codes
                let statusCode = (res as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            //unwrap data using guard. handles nil data returns
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                //decode data
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkingError.faledToDecode(error: error)))
            }
        }
        
        // !!!IMPORTANT!!! - starts the task
        dataTask.resume()
    }
}

extension APINetworkingManager {
    enum NetworkingError: Error {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case faledToDecode(error: Error)
    }
}
