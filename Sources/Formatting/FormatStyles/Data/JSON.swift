import Foundation

extension Data {
    public struct JSONFormatStyle: FormatStyle {
        private let options: JSONSerialization.WritingOptions

        public init () {
            self.options = [.prettyPrinted]
        }

        private init (options: JSONSerialization.WritingOptions) {
            self.options = options
        }

        public func format (_ data: Data) -> String? {
            (try? tryFormat(data))
        }

        public func tryFormat (_ data: Data) throws -> String? {
            let object = try JSONSerialization.jsonObject(with: data, options: [])
            let data = try JSONSerialization.data(withJSONObject: object, options: options)
            return .init(data: data, encoding: .utf8)
        }
    }
}

public extension Data.JSONFormatStyle {
    func options (_ options: JSONSerialization.WritingOptions) -> Self {
        .init(options: self.options.union(options))
    }
    
    func setOptions (_ options: JSONSerialization.WritingOptions) -> Self {
        .init(options: options)
    }
}

extension JSONSerialization.WritingOptions: Codable, @retroactive Hashable { }

public extension FormatStyle where Self == Data.JSONFormatStyle {
    static var json: Self { .init() }
}

public extension AnyFormatStyle {
    static var json: Data.JSONFormatStyle { .init() }
}
