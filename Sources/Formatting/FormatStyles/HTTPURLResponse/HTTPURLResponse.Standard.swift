import Foundation

public typealias HTTPURLResponseDefaultFormatStyle = HTTPURLResponse.StandardFormatStyle<
    DictionaryDefaultFormatStyle<AnyHashable, Any>
>

extension HTTPURLResponse {
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

        public func format (_ httpUrlResponse: HTTPURLResponse) -> String {
            var components = [String]()

            prefix(&components)
            requestLine(httpUrlResponse, &components)

            guard !options.isRequestLineOnly else {
                return components.joined(separator: "\n")
            }

            components.append("")
            headers(httpUrlResponse, &components)

            return components.joined(separator: "\n")
        }

        private func prefix (_ components: inout [String]) {
            if let prefix = options.prefix {
                components.append(prefix)
                components.append("")
            }
        }

        private func requestLine (_ httpUrlResponse: HTTPURLResponse, _ components: inout [String]) {
            let method = httpUrlResponse.statusCode.description
            let url = httpUrlResponse.url?.formatted(urlFormatStyle).ifEmpty("No URL") ?? noValue("No URL")
            let requestLine = "\(method) – \(url)"

            components.append(requestLine)
        }

        private func headers (_ httpUrlResponse: HTTPURLResponse, _ components: inout [String]) {
            components.append(
                headersFormatStyle
                    .format(httpUrlResponse.allHeaderFields)
                    .ifEmpty("No headers")
            )
        }
    }
}

public extension HTTPURLResponse.StandardFormatStyle {
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
                prefix: prefix,
                isRequestLineOnly: options.isRequestLineOnly
            ),
            url: urlFormatStyle,
            headers: headersFormatStyle
        )
    }

    func isRequestLineOnly (_ isRequestLineOnly: Bool) -> Self {
        .init(
            options: .init(
                prefix: options.prefix,
                isRequestLineOnly: isRequestLineOnly
            ),
            url: urlFormatStyle,
            headers: headersFormatStyle
        )
    }
}
