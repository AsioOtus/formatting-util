import Foundation

public extension FormatStyle {
    static func dictionary <KeyFS, ValueFS> (
        key: KeyFS,
        value: ValueFS
    ) -> Self where Self == [KeyFS.FormatInput: ValueFS.FormatInput].StandardFormatStyle<KeyFS, ValueFS> {
        .init(
            key: key,
            value: value
        )
    }

    static func dictionary <Key, Value> () -> Self
    where Self == DictionaryDefaultFormatStyle<Key, Value> {
        .init(
            key: .interpolation(),
            value: .interpolation()
        )
    }

    static func dictionary () -> Self
    where Self == DictionaryDefaultFormatStyle<String, String> {
        .init(
            key: .interpolation(),
            value: .interpolation()
        )
    }
}

public extension AnyFormatStyle {
    static func dictionary <KeyFS, ValueFS> (
        key: KeyFS,
        value: ValueFS
    ) -> [KeyFS.FormatInput: ValueFS.FormatInput].StandardFormatStyle<KeyFS, ValueFS> {
        .init(
            key: key,
            value: value
        )
    }

    static func dictionary <Key, Value> () -> DictionaryDefaultFormatStyle<Key, Value> {
        .init(
            key: .interpolation(),
            value: .interpolation()
        )
    }

    static func dictionary () -> DictionaryDefaultFormatStyle<String, String> {
        .init(
            key: .interpolation(),
            value: .interpolation()
        )
    }
}
