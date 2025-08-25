import Foundation

extension Data.DigitsFormatStyle {
    public struct Options: Sendable, Codable, Hashable {
        public let radix: Radix
        public let isPrefixed: Bool
        public let separator: String

        public init (
            radix: Radix = .hex,
            isPrefixed: Bool = false,
            separator: String = " "
        ) {
            self.radix = radix
            self.isPrefixed = isPrefixed
            self.separator = separator
        }
    }
}

extension Data.DigitsFormatStyle.Options {
    public enum Radix: Int, Sendable, Codable, Hashable {
        case bin = 2
        case oct = 8
        case dec = 10
        case hex = 16

        public var prefix: String {
            switch self {
            case .bin: "0b"
            case .oct: "0o"
            case .dec: "0d"
            case .hex: "0x"
            }
        }
    }
}

extension Data {
    public struct DigitsFormatStyle: FormatStyle {
        public let options: Options

        public init () {
            self.options = .init()
        }

        private init (options: Options) {
            self.options = options
        }

        public func format (_ data: Data) -> String {
            data
                .map { .init($0, radix: options.radix.rawValue) }
                .map { options.isPrefixed ? options.radix.prefix : "" + $0 }
                .joined(separator: options.separator)
        }
    }
}

public extension Data.DigitsFormatStyle {
    func options (_ options: Options) -> Self {
        .init(options: options)
    }

    func radix (_ radix: Options.Radix) -> Self {
        .init(
            options: .init(
                radix: radix,
                isPrefixed: options.isPrefixed,
                separator: options.separator
            )
        )
    }

    func isPrefixed (_ isPrefixed: Bool) -> Self {
        .init(
            options: .init(
                radix: options.radix,
                isPrefixed: isPrefixed,
                separator: options.separator
            )
        )
    }

    func separator (_ separator: String) -> Self {
        .init(
            options: .init(
                radix: options.radix,
                isPrefixed: options.isPrefixed,
                separator: separator
            )
        )
    }
}

public extension FormatStyle where Self == Data.DigitsFormatStyle {
    static var digits: Self { .init() }
}

public extension AnyFormatStyle {
    static var digits: Data.DigitsFormatStyle { .init() }
}
