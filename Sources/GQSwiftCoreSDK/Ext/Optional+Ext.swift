import Foundation

public extension Optional where Wrapped: Collection {
    var isNil: Bool {
        self == nil
    }
    
    var isNotNil: Bool {
        !isNil
    }
    
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

public extension Optional where Wrapped: StringProtocol {
    var toUrl: URL? {
        guard let urlString = self as? String else { return nil }
        return URL(string: urlString)
    }
}
