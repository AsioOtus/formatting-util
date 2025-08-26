import Foundation

extension URLRequest.StandardFormatStyle {
    public struct Options: Sendable, Codable, Hashable {
        public let prefix: String?
        public let isRequestLineOnly: Bool
        public let usePlaceholders: Bool

        public init (
            prefix: String? = nil,
            isRequestLineOnly: Bool = false,
            usePlaceholders: Bool = true
        ) {
            self.prefix = prefix
            self.isRequestLineOnly = isRequestLineOnly
            self.usePlaceholders = usePlaceholders
        }
    }
}
