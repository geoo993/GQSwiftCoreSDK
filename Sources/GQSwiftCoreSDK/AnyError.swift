import Foundation

public struct AnyError: Error, Equatable {
    let wrappedError: Error

    public init<E: Error>(_ wrappedError: E) {
        self.wrappedError = wrappedError
    }

    static public func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.wrappedError as NSError) == (rhs.wrappedError as NSError)
    }
}

public struct AnyLocalizedError: LocalizedError, Hashable {
    let wrappedError: LocalizedError

    public init<E: LocalizedError>(_ wrappedError: E) {
        self.wrappedError = wrappedError
    }

    static public func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.wrappedError as NSError) == (rhs.wrappedError as NSError)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedError as NSError)
    }
}
