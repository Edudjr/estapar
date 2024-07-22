//
//  CategoriesEndpoint.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

struct HelpCenterCategoriesEndpoint: Endpoint {
    var path: String {
        "/v1/helpcenter/categories"
    }
    
    var method: EndpointMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
}
