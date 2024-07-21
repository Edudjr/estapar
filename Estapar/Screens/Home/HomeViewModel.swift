//
//  HomeViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import Combine

final class HomeViewModel {
    let helpCenterViewModel: HelpCenterViewModel

    init(helpCenter: HelpCenterProtocol) {
        self.helpCenterViewModel = HelpCenterViewModel(helpCenter: helpCenter)
    }
}
