import Foundation

public struct CompositeFormatStyle<Input, Output>: FormatStyle {
    private let defaultFormatStyle: AnyFormatStyle<Input, Output>
    private let formatStyles: [AnyFormatStyle<Input, Output?>]

    public init <DefaultFS: FormatStyle> (
        _ formatStyles: [AnyFormatStyle<Input, Output?>],
        default: DefaultFS
    ) where DefaultFS.FormatInput == Input, DefaultFS.FormatOutput == Output {
        self.defaultFormatStyle = `default`.eraseToAnyFormatStyle()
        self.formatStyles = formatStyles
    }

    public func format(_ value: Input) -> Output {
        for formatStyle in formatStyles {
            if let formatted = formatStyle.format(value) {
                return formatted
            }
        }

        return defaultFormatStyle.format(value)
    }
}

extension CompositeFormatStyle: Codable {
    public init (from decoder: Decoder) throws { throw CocoaError(.featureUnsupported) }

    public func encode (to encoder: Encoder) throws { }
}

extension CompositeFormatStyle: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool { false }

    public func hash (into hasher: inout Hasher) { }
}

public extension FormatStyle {
    static func `try` <Input, Output, DefaultFS: FormatStyle> (
        _ formatStyles: AnyFormatStyle<Input, Output?>...,
        or default: DefaultFS
    ) -> Self
    where
    Self == CompositeFormatStyle<Input, Output>,
    DefaultFS.FormatInput == Input, DefaultFS.FormatOutput == Output
    {
        .init(
            formatStyles,
            default: `default`
        )
    }
}

public extension AnyFormatStyle {
    static func `try` <Input, Output, DefaultFS: FormatStyle> (
        _ formatStyles: AnyFormatStyle<Input, Output?>...,
        or default: DefaultFS
    ) -> CompositeFormatStyle<Input, Output>
    where
    DefaultFS.FormatInput == Input, DefaultFS.FormatOutput == Output
    {
        .init(
            formatStyles,
            default: `default`
        )
    }
}
