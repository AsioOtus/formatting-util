import Foundation

public typealias URLResponseDefaultFormatStyle = URLResponse.StandardFormatStyle<
    DictionaryDefaultFormatStyle<AnyHashable, Any>
>

extension URLResponse {
    public struct StandardFormatStyle<HeadersFS>: FormatStyle, Codable, Hashable
    where
    HeadersFS: FormatStyle,
    HeadersFS.FormatInput == [AnyHashable: Any],
    HeadersFS.FormatOutput == String
    {
        public let options: Options

        public let urlFormatStyle: URL.FormatStyle
        public let headersFormatStyle: HeadersFS

        public init (
            url: URL.FormatStyle,
            headers: HeadersFS
        ) {
            self.options = .init()
            self.urlFormatStyle = url
            self.headersFormatStyle = headers
        }

        private init (
            options: Options,
            url: URL.FormatStyle,
            headers: HeadersFS
        ) {
            self.options = options
            self.urlFormatStyle = url
            self.headersFormatStyle = headers
        }

        public func format (_ urlResponse: URLResponse) -> String {
            var components = [String]()

            prefix(&components)
            requestLine(urlResponse, &components)

            return components.joined(separator: "\n")
        }

        private func prefix (_ components: inout [String]) {
            if let prefix = options.prefix {
                components.append(prefix)
                components.append("")
            }
        }

        private func requestLine (_ urlResponse: URLResponse, _ components: inout [String]) {
            let url = urlResponse.url?.formatted(urlFormatStyle).ifEmpty("No URL") ?? noValue("No URL")
            let requestLine = "\(url)"

            components.append(requestLine)
        }
    }
}

public extension URLResponse.StandardFormatStyle {
    func options (_ options: Options) -> Self {
        .init(
            options: options,
            url: urlFormatStyle,
            headers: headersFormatStyle
        )
    }

    func prefix (_ prefix: String) -> Self {
        .init(
            options: .init(
                prefix: prefix
            ),
            url: urlFormatStyle,
            headers: headersFormatStyle
        )
    }
}
