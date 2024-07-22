//
//  FAQEndpoint.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import Foundation

struct HelpCenterCategoryEndpoint: Endpoint {
    let categoryID: String

    var path: String {
        "/v1/helpcenter/categories/\(categoryID)"
    }

    var method: EndpointMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        nil
    }
}
