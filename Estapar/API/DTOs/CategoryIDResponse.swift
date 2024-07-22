//
//  CategoryIDResponse.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

struct CategoryIDResponseDTO: Decodable {
    let id: String?
    let title: String?
    let type: String?
    let category: String?
    let items: [CategorySectionDTO]?
}
