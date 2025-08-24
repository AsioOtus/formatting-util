import Foundation

public struct ErrorFormatStyle: FormatStyle {
    public init () { }

    public func format (_ error: Error) -> String {
        .init(describing: error)
    }
}

public extension FormatStyle {
    static func error () -> Self where Self == ErrorFormatStyle { .init() }
}

public extension AnyFormatStyle {
    static func error () -> ErrorFormatStyle { .init() }
}
