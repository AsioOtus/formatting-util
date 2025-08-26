import Foundation

extension URLError {
    public struct DefaultFormatStyleOptions: Sendable, Codable, Hashable {
        public let prefix: String?

        public init (
            prefix: String? = nil
        ) {
            self.prefix = prefix
        }
    }
}

extension URLError.DefaultFormatStyleOptions {
    public struct Components: OptionSet, Sendable, Codable, Hashable {
        public let rawValue: UInt8

        public init (rawValue: UInt8) {
            self.rawValue = rawValue
        }

        public static let urlRequest   = Self(rawValue: 1 << 0)
        public static let responseData = Self(rawValue: 1 << 1)
        public static let urlResponse  = Self(rawValue: 1 << 2)
        public static let error        = Self(rawValue: 1 << 3)
        public static let all          = Self([Self.urlRequest, Self.responseData, Self.urlResponse, Self.error])
    }
}
