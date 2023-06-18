public extension Bool {
    func then(closure: () -> Void) {
        if self {
            closure()
        }
    }

    var isFalse: Bool {
        !self
    }
}
