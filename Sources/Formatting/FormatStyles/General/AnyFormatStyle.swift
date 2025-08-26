import Foundation

public struct AnyFormatStyle<FormatInput, FormatOutput>: FormatStyle {
    private let _format: (FormatInput) -> FormatOutput

    init<S: FormatStyle>(_ style: S) where S.FormatInput == FormatInput, S.FormatOutput == FormatOutput {
        self._format = style.format
    }

    public func format(_ value: FormatInput) -> FormatOutput {
        _format(value)
    }
}

extension AnyFormatStyle: Codable {
    public init (from decoder: Decoder) throws { throw CocoaError(.featureUnsupported) }

    public func encode (to encoder: Encoder) throws { }
}

extension AnyFormatStyle: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool { false }

    public func hash (into hasher: inout Hasher) { }
}

public extension FormatStyle {
    func eraseToAnyFormatStyle () -> AnyFormatStyle<FormatInput, FormatOutput> {
        .init(self)
    }
}
