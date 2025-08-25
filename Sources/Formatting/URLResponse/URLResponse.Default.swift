import Foundation

extension URLResponse.DefaultFormatStyle {
    public struct Options: Sendable, Codable, Hashable {
        public let prefix: String?

        public init (
            prefix: String? = nil
        ) {
            self.prefix = prefix
        }
    }
}

extension URLResponse {
    public struct DefaultFormatStyle<HeadersFS>: FormatStyle, Codable, Hashable
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

public extension URLResponse.DefaultFormatStyle {
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

public extension FormatStyle {
    static func urlResponse <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS
    ) -> Self where Self == URLResponse.DefaultFormatStyle<HeadersFS> {
        .init(
            url: url,
            headers: headers
        )
    }

    static func urlResponse (
        url: URL.FormatStyle = .url,
        headers: [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>> = .dictionary()
    ) -> Self where Self == URLResponse.DefaultFormatStyle<[AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>>> {
        .init(
            url: url,
            headers: headers
        )
    }
}

public extension AnyFormatStyle {
    static func urlResponse <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS
    ) -> URLResponse.DefaultFormatStyle<HeadersFS> {
        .init(
            url: url,
            headers: headers
        )
    }

    static func urlResponse (
        url: URL.FormatStyle = .url,
        headers: [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>> = .dictionary()
    ) -> URLResponse.DefaultFormatStyle<[AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>>> {
        .init(
            url: url,
            headers: headers
        )
    }
}
