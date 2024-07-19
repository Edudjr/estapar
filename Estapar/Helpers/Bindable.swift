//
//  Bindable.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

//import Combine
//
//final class Bindable<Value> {
//    private var cancellable: AnyCancellable?
//    fileprivate var callback: ((Value) -> Void)?
//    private var onUpdateHandler: (() -> Void)?
//
//
//    @discardableResult
//    func bind<P: Publisher>(to publisher: P) -> Self
//    where P.Output == Value, P.Failure == Never {
//        cancellable = publisher
//            .compactMap { $0 }
//            .sink { [weak self] value in
//                self?.callback?(value)
//                self?.onUpdateHandler?()
//            }
//        return self
//    }
//
//    @discardableResult
//    func onUpdate(_ handler: @escaping () -> Void) -> Self {
//        onUpdateHandler = handler
//        return self
//    }
//}
//
//@propertyWrapper
//class Bind<Value> {
//    private let bindable: Bindable<Value>
//
//    var wrappedValue: Value
//
//    var projectedValue: Bindable<Value>{
//        bindable
//    }
//
//    init(wrappedValue: Value) {
//        self.wrappedValue = wrappedValue
//        self.bindable = Bindable()
//
//        bindable.callback =  { [weak self] value in
//            self?.wrappedValue = value
//        }
//    }
//}
//
//extension Publisher where Failure == Never {
//    mutating func bind(_ bindable: Bindable<Output>, onUpdate: (() -> Void)? = nil) {
//        bindable
//            .bind(to: self)
//            .onUpdate {
//                onUpdate?()
//            }
//    }
//}
