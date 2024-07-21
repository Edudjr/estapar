//
//  HelpCenter.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

protocol HelpCenterProtocol {
    func categories() async -> [HelpCenterCategory]
    func faq(forCategoryId: String) async -> [FAQItem]
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

    func faq(forCategoryId: String) async -> [FAQItem] {
        try? await Task.sleep(for: .seconds(1))

        return [
            FAQItem(category: "Uso da tag de pedágio Zul+",
                    questions: ["Como funciona a tarifa de recarga?"]),
            FAQItem(category: "Uso da tag de pedágio Zul+",
                    questions: ["Como funciona a tarifa de recarga?"]),
            FAQItem(category: "Uso da tag de pedágio Zul+",
                    questions: ["Como funciona a tarifa de recarga?"]),
            FAQItem(category: "Uso da tag de pedágio Zul+",
                    questions: ["Como funciona a tarifa de recarga?"]),
            FAQItem(category: "Uso da tag de pedágio Zul+",
                    questions: ["Como funciona a tarifa de recarga?"])
        ]
    }
}

struct HelpCenterCategory {
    let id: String = "1234"
    let title: String
    let articlesNumber: Int
}

struct FAQItem {
    let category: String
    let questions: [String]
}
