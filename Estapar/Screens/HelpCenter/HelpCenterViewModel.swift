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
    let user: UserProtocol

    private var cancellables = Set<AnyCancellable>()

    @Published var helloUserMessage: String?
    @Published var canWeHelpMessage: String?
    @Published var headerBackgroundImage: String?
    @Published var categories = [HelpCenterCategoryViewModel]()
    @Published var errorMessage: String?
    
    @ConcurrentLoading var isLoading = false

    init(helpCenter: HelpCenterProtocol, user: UserProtocol) {
        self.helpCenter = helpCenter
        self.user = user
        bind()
    }

    func loadCategories() {
        Task {
            isLoading = true
            do {
                try await helpCenter.requestCategories()
            } catch {
                errorMessage = EstaparError.categoriesError.errorDescription
            }
            isLoading = false
        }
    }

    func loadHeader() {
        Task {
            isLoading = true
            do {
                try await  user.requestUser()
            } catch {
                errorMessage = EstaparError.categoriesError.errorDescription
            }
            isLoading = false
        }
    }

    func bind() {
        helpCenter.headerPublisher
            .combineLatest(user.firstNamePublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (header, firstName) in
                guard let self else { return }

                if let header {
                    self.canWeHelpMessage = header.line2
                    self.headerBackgroundImage = header.image
                }

                if let header, let firstName {
                    self.helloUserMessage = header.line1?.replacingOccurrences(of: "%firstName%", with: firstName)
                }
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
    }
}
