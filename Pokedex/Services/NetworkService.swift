//
//  NetworkService.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: could consider using signleton
class NetworkService: NetworkServiceProtocol {
    private let semaphore = DispatchSemaphore(value: 5)
    
    func fetch<T:Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        semaphore.wait()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {
                self.semaphore.signal()
            }
            
            if let error {
                self.completeOnMain(.failure(error), completion: completion)
                return
            }
            
            guard let data else {
                let error = NSError(domain: "NetworkServiceError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                self.completeOnMain(.failure(error), completion: completion)
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                self.completeOnMain(.success(decodedObject), completion: completion)
            } catch {
                self.completeOnMain(.failure(error), completion: completion)
            }
        }
        
        task.resume()
    }
    
    private func completeOnMain<T>(_ result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
