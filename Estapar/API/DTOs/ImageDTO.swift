//
//  ImageDTO.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

struct ImageDTO: Decodable {
    let oneX: String?
    let twoX: String?
    let threeX: String?

    private enum CodingKeys : String, CodingKey {
        case oneX = "@1x"
        case twoX = "@2x"
        case threeX = "@3x"
    }
}
