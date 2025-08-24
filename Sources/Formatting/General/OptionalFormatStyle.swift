import Foundation

public struct OptionalFormatStyle<InnerFS: FormatStyle>: FormatStyle {
    public let innerFormatStyle: InnerFS

    public init(
        innerFormatStyle: InnerFS
    ) {
        self.innerFormatStyle = innerFormatStyle
    }

    public func format(_ value: InnerFS.FormatInput) -> InnerFS.FormatOutput? {
        innerFormatStyle.format(value)
    }
}

extension OptionalFormatStyle: Codable {
    public init (from decoder: Decoder) throws { throw CocoaError(.featureUnsupported) }

    public func encode (to encoder: Encoder) throws { }
}

extension OptionalFormatStyle: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool { false }

    public func hash (into hasher: inout Hasher) { }
}

public extension FormatStyle {
    var optional: OptionalFormatStyle<Self> {
        .init(innerFormatStyle: self)
    }
}
