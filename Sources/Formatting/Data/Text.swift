import Foundation

extension Data {
    public struct TextFormatStyle: FormatStyle {
        public var encoding: String.Encoding

        public init () {
            self.encoding = .utf8
        }

        private init (encoding: String.Encoding) {
            self.encoding = encoding
        }

        public func format (_ data: Data) -> String? {
            .init(data: data, encoding: encoding)
        }
    }
}

public extension Data.TextFormatStyle {
    func encoding (_ encoding: String.Encoding) -> Self {
        .init(encoding: encoding)
    }
}

extension String.Encoding: Codable { }

public extension FormatStyle where Self == Data.TextFormatStyle {
    static var text: Self { .init() }
}

public extension AnyFormatStyle {
    static var text: Data.TextFormatStyle { .init() }
}
