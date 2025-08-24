import Foundation

public struct ConstantFormatStyle<FormatInput, FormatOutput>: FormatStyle where FormatOutput: Codable, FormatOutput: Hashable {
    public let value: FormatOutput

    public init(
        value: FormatOutput
    ) {
        self.value = value
    }

    public func format(_: FormatInput) -> FormatOutput {
        value
    }
}

public extension FormatStyle {
    static func constant <FormatInput, FormatOutput> (value: FormatOutput) -> Self
    where
    Self == ConstantFormatStyle<FormatInput, FormatOutput>
    {
        .init(value: value)
    }
}

public extension AnyFormatStyle where FormatOutput: Codable, FormatOutput: Hashable {
    static func interpolation (value: FormatOutput) -> ConstantFormatStyle<FormatInput, FormatOutput> {
        .init(value: value)
    }
}
