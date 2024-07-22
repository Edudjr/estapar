//
//  NetworkManager.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(baseURL: URL, endpoint: Endpoint, type: T.Type) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    func request<T: Decodable>(baseURL: URL, endpoint: Endpoint, type: T.Type) async throws -> T {
        let requestURL = baseURL.appendingPathComponent(endpoint.path)
        
        guard var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
