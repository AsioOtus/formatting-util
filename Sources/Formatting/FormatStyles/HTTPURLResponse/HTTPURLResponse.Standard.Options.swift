import Foundation

extension HTTPURLResponse.StandardFormatStyle {
    public struct Options: Sendable, Codable, Hashable {
        public let prefix: String?
        public let isRequestLineOnly: Bool

        public init (
            prefix: String? = nil,
            isRequestLineOnly: Bool = false
        ) {
            self.prefix = prefix
            self.isRequestLineOnly = isRequestLineOnly
        }
    }
}
