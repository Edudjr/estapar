//
//  CategoriesResponseDTO.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

struct CategoriesResponseDTO: Decodable {
    let header: HeaderDTO?
    let items: [CategoryDTO]?
}
