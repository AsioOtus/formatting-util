import Foundation

extension String {
    public struct TransparentFormatStyle: FormatStyle {
        public init () { }

        public func format (_ string: String) -> String {
            string
        }
    }
}

public extension FormatStyle where Self == String.TransparentFormatStyle {
    static var string: Self { .init() }
}

public extension AnyFormatStyle {
    static var string: String.TransparentFormatStyle { .init() }
}
