import Foundation

public struct OptionalCastingFormatStyle<CastingFS: FormatStyle, Input>: FormatStyle {
    public let castingFormatStyle: CastingFS

    public init (
        casting: CastingFS
    ) {
        self.castingFormatStyle = casting
    }

    public func format (_ value: Input) -> CastingFS.FormatOutput? {
        if let castedValue = value as? CastingFS.FormatInput {
            return castingFormatStyle.format(castedValue)
        }

        return nil
    }
}

public extension FormatStyle {
    static func cast <CastingFS: FormatStyle, Input> (to casting: CastingFS) -> Self
    where
    Self == OptionalCastingFormatStyle<CastingFS, Input>
    {
        .init(casting: casting)
    }
}

public extension FormatStyle {
    static func cast <CastingFS: FormatStyle, Input> (to casting: CastingFS) -> OptionalCastingFormatStyle<CastingFS, Input> {
        .init(casting: casting)
    }
}
