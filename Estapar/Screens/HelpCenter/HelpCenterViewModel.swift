//
//  HelpCenterViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 20/07/24.
//

import Combine
import Foundation

final class HelpCenterViewModel {
    let helpCenter: HelpCenterProtocol
    private var cancellables = Set<AnyCancellable>()

//    @Published var header: Header?

    @Published var helloUserMessage: String?
    @Published var canWeHelpMessage: String?
    @Published var headerBackgroundImage: String?
    @Published var categories = [HelpCenterCategoryViewModel]()
    @Published var isLoading = false

    init(helpCenter: HelpCenterProtocol) {
        self.helpCenter = helpCenter
        bind()
    }

    func loadCategories() {
        helpCenter.requestCategories()
    }

    func bind() {
        helpCenter.headerPublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] header in
                guard let self else { return }
                self.helloUserMessage = header.line1
                self.canWeHelpMessage = header.line2
                self.headerBackgroundImage = header.image
            }
            .store(in: &cancellables)

        helpCenter.categoriesPublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] items in
                guard let self else { return }
                self.categories = items.map(HelpCenterCategoryViewModel.init)
            }
            .store(in: &cancellables)

//        helpCenter.categoriesPublisher
//            .receive(on: DispatchQueue.main)
//            .compactMap { $0 }
//            .sink { [weak self] items in
//                guard let self else { return }
//                self.categories = items.map(HelpCenterCategoryViewModel.init)
//            }
//            .store(in: &cancellables)

        helpCenter.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] isLoading in
                guard let self else { return }
                self.isLoading = isLoading
            }
            .store(in: &cancellables)
    }
}
