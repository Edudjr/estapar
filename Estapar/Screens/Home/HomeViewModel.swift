//
//  HomeViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import Combine

/**
 
 */
final class HomeViewModel {
    @Published private(set) var navigateToHelpCenterView: HelpCenterViewModel?

    private let helpCenter: HelpCenterProtocol
    private let user: UserProtocol

    init(helpCenter: HelpCenterProtocol, user: UserProtocol) {
        self.helpCenter = helpCenter
        self.user = user
    }

    func openHelpCenterTap() {
        navigateToHelpCenterView = HelpCenterViewModel(helpCenter: helpCenter, user: user)
    }
}
