import Foundation

public struct LocalizedErrorFormatStyle: FormatStyle {
    public init () { }

    public func format (_ error: Error) -> String {
        error.localizedDescription
    }
}

public extension FormatStyle {
    static func localized () -> Self where Self == LocalizedErrorFormatStyle { .init() }
}

public extension AnyFormatStyle {
    static func localized () -> LocalizedErrorFormatStyle { .init() }
}
