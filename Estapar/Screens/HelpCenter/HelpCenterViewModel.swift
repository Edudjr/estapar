//
//  HelpCenterViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 20/07/24.
//

import Combine

final class HelpCenterViewModel {
    let helpCenter: HelpCenterProtocol

    @Published var categories = [HelpCenterCategoryViewModel]()
    @Published var isLoading = false

    init(helpCenter: HelpCenterProtocol) {
        self.helpCenter = helpCenter
    }

    func loadCategories() {
        Task {
            isLoading = true
            do {
                let categories = try await helpCenter.categories()
                self.categories = categories.map(HelpCenterCategoryViewModel.init)
            } catch {
                // TODO: handle error
            }
            isLoading = false
        }
    }
}
