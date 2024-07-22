//
//  Endpoint.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation
// Define a protocol for API Endpoints
protocol Endpoint {
    var path: String { get }
    var method: EndpointMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

enum EndpointMethod: String {
    case get = "GET"
    case post = "POST"
}
