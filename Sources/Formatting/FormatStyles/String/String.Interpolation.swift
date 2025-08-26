import Foundation

extension String {
    public struct InterpolationFormatStyle<Input>: FormatStyle {
        public init () { }

        public func format (_ input: Input) -> String {
            "\(input)"
        }
    }
}

public extension FormatStyle {
    static func interpolation <Input> (_ inputType: Input.Type = Input.self) -> Self
    where Self == String.InterpolationFormatStyle<Input> {
        .init()
    }
}

public extension AnyFormatStyle {
    static func interpolation <Input> (_ inputType: Input.Type = Input.self) -> String.InterpolationFormatStyle<Input> {
        .init()
    }
}
