import Foundation

extension NSError {
    public struct DefaultFormatStyle: FormatStyle {
        public init () { }

        public func format (_ error: NSError) -> String {
            var components: [String] = []

            components.append("Domain: \(error.domain)")
            components.append("Code: \(error.code)")

            if !error.localizedDescription.isEmpty {
                components.append("Description: \(error.localizedDescription)")
            }

            if let reason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String {
                components.append("Reason: \(reason)")
            }

            if let suggestion = error.userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String {
                components.append("Recovery: \(suggestion)")
            }

            return components.joined(separator: "\n")
        }
    }
}

public extension FormatStyle {
    static func nsError () -> Self where Self == NSError.DefaultFormatStyle { .init() }
}

public extension AnyFormatStyle {
    static func nsError () -> NSError.DefaultFormatStyle { .init() }
}
