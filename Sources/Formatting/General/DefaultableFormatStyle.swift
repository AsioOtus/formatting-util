import Foundation

public struct DefaultableFormatStyle<FormatOutput, InnerFS: FormatStyle>: FormatStyle
where
InnerFS.FormatOutput == FormatOutput?
{
    public let defaultValue: FormatOutput
    public let innerFormatStyle: InnerFS

    public init(
        defaultValue: FormatOutput,
        innerFormatStyle: InnerFS
    ) {
        self.defaultValue = defaultValue
        self.innerFormatStyle = innerFormatStyle
    }

    public func format(_ value: InnerFS.FormatInput) -> FormatOutput {
        innerFormatStyle.format(value) ?? defaultValue
    }
}

extension DefaultableFormatStyle: Codable {
    public init (from decoder: Decoder) throws { throw CocoaError(.featureUnsupported) }

    public func encode (to encoder: Encoder) throws { }
}

extension DefaultableFormatStyle: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool { false }

    public func hash (into hasher: inout Hasher) { }
}

public extension FormatStyle {
    func withDefault <Value> (_ value: Value) -> DefaultableFormatStyle<Value, Self> where Self.FormatOutput == Value? {
        .init(
            defaultValue: value,
            innerFormatStyle: self
        )
    }
}
