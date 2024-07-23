//
//  Endpoint.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: EndpointMethod { get }
    var queryItems: [URLQueryItem]? { get }
}
