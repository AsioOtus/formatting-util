import Foundation

public struct OptionalCompositeFormatStyle<Input, Output>: FormatStyle {
    private let formatStyles: [AnyFormatStyle<Input, Output?>]

    public init (_ formatStyles: [AnyFormatStyle<Input, Output?>]) {
        self.formatStyles = formatStyles
    }

    public func format(_ value: Input) -> Output? {
        for formatStyle in formatStyles {
            if let formatted = formatStyle.format(value) {
                return formatted
            }
        }

        return nil
    }
}

extension OptionalCompositeFormatStyle: Codable {
    public init (from decoder: Decoder) throws { throw CocoaError(.featureUnsupported) }

    public func encode (to encoder: Encoder) throws { }
}

extension OptionalCompositeFormatStyle: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool { false }

    public func hash (into hasher: inout Hasher) { }
}

extension FormatStyle {
    static func compose <Input, Output> (
        _ formatStyles: AnyFormatStyle<Input, Output?>...
    ) -> Self where Self == OptionalCompositeFormatStyle<Input, Output> {
        .init(formatStyles)
    }
}

extension AnyFormatStyle {
    static func compose <Input, Output> (
        _ formatStyles: AnyFormatStyle<Input, Output?>...
    ) -> OptionalCompositeFormatStyle<Input, Output> {
        .init(formatStyles)
    }
}
