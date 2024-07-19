//
//  HomeViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import Combine

final class HomeViewModel {
    let helpCenter: HelpCenterProtocol

    @Published var cards: [HelpCenterCardViewModel]?

    init(helpCenter: HelpCenterProtocol) {
        self.helpCenter = helpCenter
    }

    func loadCards() {
        Task {
            let categories = await helpCenter.categories()
            cards = categories.map(HelpCenterCardViewModel.init)
        }
    }
}
