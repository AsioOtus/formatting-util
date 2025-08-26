import Foundation

extension URLResponse.StandardFormatStyle {
    public struct Options: Sendable, Codable, Hashable {
        public let prefix: String?

        public init (
            prefix: String? = nil
        ) {
            self.prefix = prefix
        }
    }
}
