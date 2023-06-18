import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(arguments: CVarArg...) -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return String(format: localizedString, arguments: arguments)
    }

    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

public extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}
