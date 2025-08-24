import Foundation

extension Data {
    public struct Base64FormatStyle: FormatStyle {
        private let options: Data.Base64EncodingOptions

        public init () {
            self.options = []
        }

        private init (options: Data.Base64EncodingOptions) {
            self.options = options
        }

        public func format (_ data: Data) -> String {
            data.base64EncodedString(options: options)
        }
    }
}

public extension Data.Base64FormatStyle {
    func options (_ options: Data.Base64EncodingOptions) -> Self {
        .init(options: self.options.union(options))
    }

    func setOptions (_ options: Data.Base64EncodingOptions) -> Self {
        .init(options: options)
    }
}

extension Data.Base64EncodingOptions: Codable, @retroactive Hashable { }

extension FormatStyle where Self == Data.Base64FormatStyle {
    static var base64: Self { .init() }
}

public extension AnyFormatStyle {
    static var base64: Data.Base64FormatStyle { .init() }
}
