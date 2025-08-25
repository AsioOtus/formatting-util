import Foundation

public struct CastingFormatStyle<CastingFS, DefaultFS>: FormatStyle
where
CastingFS: FormatStyle,
DefaultFS: FormatStyle,
CastingFS.FormatOutput == DefaultFS.FormatOutput
{
    public let castingFormatStyle: CastingFS
    public let defaultFormatStyle: DefaultFS

    public init (
        casting: CastingFS,
        default: DefaultFS
    ) {
        self.castingFormatStyle = casting
        self.defaultFormatStyle = `default`
    }

    public func format (_ value: DefaultFS.FormatInput) -> DefaultFS.FormatOutput {
        if let castedValue = value as? CastingFS.FormatInput {
            castingFormatStyle.format(castedValue)
        } else {
            defaultFormatStyle.format(value)
        }
    }
}

public extension FormatStyle {
    static func cast <CastingFS, DefaultFS> (
        to casting: CastingFS,
        or default: DefaultFS
    ) -> Self
    where
    CastingFS: FormatStyle,
    DefaultFS: FormatStyle,
    Self == CastingFormatStyle<CastingFS, DefaultFS>
    {
        .init(
            casting: casting,
            default: `default`
        )
    }
}

public extension FormatStyle {
    static func cast <CastingFS, DefaultFS> (
        to casting: CastingFS,
        or default: DefaultFS
    ) -> CastingFormatStyle<CastingFS, DefaultFS>
    where
    CastingFS: FormatStyle,
    DefaultFS: FormatStyle
    {
        .init(
            casting: casting,
            default: `default`
        )
    }
}
