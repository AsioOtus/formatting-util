import Foundation

extension String {
    public struct DescribingFormatStyle<Input>: FormatStyle {
        public init () { }

        public func format (_ input: Input) -> String {
            .init(describing: input)
        }
    }
}

public extension FormatStyle {
    static func describing <Input> () -> Self where Self == String.DescribingFormatStyle<Input> {
        .init()
    }
}

public extension AnyFormatStyle {
    static func describing <Input> () -> String.DescribingFormatStyle<Input> {
        .init()
    }
}
