import Foundation

extension Dictionary.DefaultFormatStyle {
    public struct Options: Sendable, Codable, Hashable {
        public let separator: String
        public let withBrackets: Bool
        public let padding: String
        public let paddingSize: Int

        public init (
            separator: String = "\n",
            withBrackets: Bool = false,
            padding: String = " ",
            paddingSize: Int = 0
        ) {
            self.separator = separator
            self.withBrackets = withBrackets
            self.padding = padding
            self.paddingSize = paddingSize
        }
    }
}

extension Dictionary {
    public struct DefaultFormatStyle<KeyFS, ValueFS>: FormatStyle
    where
    KeyFS: FormatStyle,
    KeyFS.FormatInput == Key,
    KeyFS.FormatOutput == String,
    ValueFS: FormatStyle,
    ValueFS.FormatInput == Value,
    ValueFS.FormatOutput == String
    {
        public let options: Options
        public let keyFormatStyle: KeyFS
        public let valueFormatStyle: ValueFS

        public init (
            key: KeyFS,
            value: ValueFS
        ) {
            self.options = .init()
            self.keyFormatStyle = key
            self.valueFormatStyle = value
        }

        private init (
            options: Options,
            key: KeyFS,
            value: ValueFS
        ) {
            self.options = options
            self.keyFormatStyle = key
            self.valueFormatStyle = value
        }

        public func format (_ dictionary: Dictionary<Key, Value>) -> String {
            let padding = (0..<options.paddingSize)
                .map { _ in options.padding }
                .joined()

            var string = dictionary
                .map { "\(keyFormatStyle.format($0.key)): \(valueFormatStyle.format($0.value))" }
                .map { padding + $0 }
                .joined(separator: options.separator)

            if options.withBrackets {
                string = """
                [
                \(string)
                ]
                """
            }

            return string
        }
    }
}

public extension Dictionary.DefaultFormatStyle {
    func options (_ options: Options) -> Self {
        .init(
            options: options,
            key: keyFormatStyle,
            value: valueFormatStyle
        )
    }

    func pretty () -> Self {
        .init(
            options: .init(
                separator: "\n",
                withBrackets: true,
                padding: " ",
                paddingSize: 4
            ),
            key: keyFormatStyle,
            value: valueFormatStyle
        )
    }

    func separator (_ separator: String) -> Self {
        .init(
            options: .init(
                separator: separator,
                withBrackets: options.withBrackets,
                padding: options.padding,
                paddingSize: options.paddingSize
            ),
            key: keyFormatStyle,
            value: valueFormatStyle
        )
    }

    func withBrackets (_ withBrackets: Bool) -> Self {
        .init(
            options: .init(
                separator: options.separator,
                withBrackets: withBrackets,
                padding: options.padding,
                paddingSize: options.paddingSize
            ),
            key: keyFormatStyle,
            value: valueFormatStyle
        )
    }

    func padding (_ padding: String) -> Self {
        .init(
            options: .init(
                separator: options.separator,
                withBrackets: options.withBrackets,
                padding: padding,
                paddingSize: options.paddingSize
            ),
            key: keyFormatStyle,
            value: valueFormatStyle
        )
    }

    func paddingSize (_ paddingSize: Int) -> Self {
        .init(
            options: .init(
                separator: options.separator,
                withBrackets: options.withBrackets,
                padding: options.padding,
                paddingSize: paddingSize
            ),
            key: keyFormatStyle,
            value: valueFormatStyle
        )
    }
}

extension FormatStyle {
    static func dictionary <KeyFS, ValueFS> (
        key: KeyFS,
        value: ValueFS
    ) -> Self
    where
    KeyFS: FormatStyle,
    ValueFS: FormatStyle,
    Self == [KeyFS.FormatInput: ValueFS.FormatInput].DefaultFormatStyle<KeyFS, ValueFS>
    {
        .init(
            key: key,
            value: value
        )
    }

    static func dictionary <Key, Value> () -> Self
    where
    Self == [Key: Value].DefaultFormatStyle<String.InterpolationFormatStyle<Key>, String.InterpolationFormatStyle<Value>>
    {
        .init(
            key: .interpolation(),
            value: .interpolation()
        )
    }

    static func dictionary () -> Self
    where
    Self == [String: String].DefaultFormatStyle<String.TransparentFormatStyle, String.TransparentFormatStyle>
    {
        .init(
            key: .string,
            value: .string
        )
    }
}

extension AnyFormatStyle {
    static func dictionary <KeyFS, ValueFS> (
        key: KeyFS,
        value: ValueFS
    ) -> [KeyFS.FormatInput: ValueFS.FormatInput].DefaultFormatStyle<KeyFS, ValueFS>
    where
    KeyFS: FormatStyle,
    ValueFS: FormatStyle
    {
        .init(
            key: key,
            value: value
        )
    }

    static func dictionary <Key, Value> () -> [Key: Value].DefaultFormatStyle<String.InterpolationFormatStyle<Key>, String.InterpolationFormatStyle<Value>>
    {
        .init(
            key: .interpolation(),
            value: .interpolation()
        )
    }

    static func dictionary () -> [String: String].DefaultFormatStyle<String.TransparentFormatStyle, String.TransparentFormatStyle>
    {
        .init(
            key: .string,
            value: .string
        )
    }
}
