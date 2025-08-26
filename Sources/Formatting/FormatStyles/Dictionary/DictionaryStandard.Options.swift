import Foundation

extension Dictionary.StandardFormatStyle {
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
