import Foundation

extension String {
    public struct InterpolationFormatStyle<Value>: FormatStyle {
        public init () { }

        public func format (_ value: Value) -> String {
            "\(value)"
        }
    }
}

public extension FormatStyle {
    static func interpolation <Value> () -> Self where Self == String.InterpolationFormatStyle<Value> { .init() }
}

public extension AnyFormatStyle {
    static func interpolation <Value> () -> String.InterpolationFormatStyle<Value> { .init() }
}
