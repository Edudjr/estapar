//
//  CategorySectionDTO.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

struct CategorySectionDTO: Decodable {
    let id: String?
    let title: String?
    let type: String?
    let items: [CategoryArticleDTO]?
}
