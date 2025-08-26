import Foundation

public typealias DictionaryDefaultFormatStyle<Key, Value> = [Key: Value].StandardFormatStyle<
    String.InterpolationFormatStyle<Key>,
    String.InterpolationFormatStyle<Value>
> where Key: Hashable

extension Dictionary {
    public struct StandardFormatStyle<KeyFS, ValueFS>: FormatStyle
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
                string =
                """
                [
                \(string)
                ]
                """
            }

            return string
        }
    }
}

public extension Dictionary.StandardFormatStyle {
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
