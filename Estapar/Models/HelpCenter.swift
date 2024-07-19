//
//  HelpCenter.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

protocol HelpCenterProtocol {
    func categories() async -> [HelpCenterCategory]
}

final class HelpCenter: HelpCenterProtocol {
    func categories() async -> [HelpCenterCategory] {
        try? await Task.sleep(for: .seconds(1))

        return [
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18),
            HelpCenterCategory(title: "Estacionamento Rotativo", articlesNumber: 18)
        ]
    }
}

struct HelpCenterCategory {
    let title: String
    let articlesNumber: Int
}
