//
//  ConcurrentLoading.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Combine
import Foundation

/**
 A property wrapper that manages a loading state with an internal counter. Useful for waiting multiple loading operations to complete
 before setting the loading state to `false` again.

 The loading state (`isLoading`) is set to `true` when there are one or more ongoing operations,
 and set to `false` when all operations have completed.
 */
@propertyWrapper
final class ConcurrentLoading {
    private var counter = 0
    @Published private var isLoading: Bool

    var wrappedValue: Bool {
        get { isLoading }
        set {
            if newValue {
                counter += 1
                if counter == 1 && !isLoading {
                    isLoading = true
                }
            } else {
                if counter > 0 {
                    counter -= 1
                    if counter == 0 {
                        isLoading = false
                    }
                }
            }
        }
    }

    var projectedValue: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }

    init(wrappedValue: Bool) {
        self.isLoading = wrappedValue
    }
}
