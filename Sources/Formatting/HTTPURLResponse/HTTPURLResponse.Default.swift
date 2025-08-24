import Foundation

extension HTTPURLResponse.DefaultFormatStyle {
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

extension HTTPURLResponse {
    public struct DefaultFormatStyle<BodyFS, HeadersFS>: FormatStyle, Codable, Hashable
    where
    BodyFS: FormatStyle,
    BodyFS.FormatInput == Data,
    BodyFS.FormatOutput == String?,
    HeadersFS: FormatStyle,
    HeadersFS.FormatInput == [AnyHashable: Any],
    HeadersFS.FormatOutput == String
    {
        public let options: Options

        public let urlFormatStyle: URL.FormatStyle
        public let bodyFormatStyle: BodyFS
        public let headersFormatStyle: HeadersFS

        public init (
            url: URL.FormatStyle,
            body: BodyFS,
            headers: HeadersFS
        ) {
            self.options = .init()
            self.urlFormatStyle = url
            self.bodyFormatStyle = body
            self.headersFormatStyle = headers
        }

        private init (
            options: Options,
            url: URL.FormatStyle,
            body: BodyFS,
            headers: HeadersFS
        ) {
            self.options = options
            self.urlFormatStyle = url
            self.bodyFormatStyle = body
            self.headersFormatStyle = headers
        }

        public func format (_ value: (HTTPURLResponse, Data?)) -> String {
            let httpUrlResponse = value.0
            let data = value.1

            var components = [String]()

            prefix(&components)
            requestLine(httpUrlResponse, &components)

            guard !options.isRequestLineOnly else {
                return components.joined(separator: "\n")
            }

            components.append("")
            headers(httpUrlResponse, &components)
            components.append("")
            body(data, &components)

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

        private func body (_ body: Data?, _ components: inout [String]) {
            if let body {
                components.append(
                    bodyFormatStyle
                        .format(body)
                        .ifNil("Body representation is nil")
                        .ifEmpty("Body representation is empty")
                )
            } else {
                components.append(noValue("No body"))
            }
        }
    }
}

public extension HTTPURLResponse.DefaultFormatStyle {
    func options (_ options: Options) -> Self {
        .init(
            options: options,
            url: urlFormatStyle,
            body: bodyFormatStyle,
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
            body: bodyFormatStyle,
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
            body: bodyFormatStyle,
            headers: headersFormatStyle
        )
    }
}

extension FormatStyle {
    static func urlRequest <BodyFS, HeadersFS> (
        url: URL.FormatStyle = .url,
        body: BodyFS,
        headers: HeadersFS
    ) -> Self where Self == HTTPURLResponse.DefaultFormatStyle<BodyFS, HeadersFS> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }

    static func urlRequest <BodyFS> (
        url: URL.FormatStyle = .url,
        body: BodyFS,
        headers: [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>> = .dictionary()
    ) -> Self where Self == HTTPURLResponse.DefaultFormatStyle<BodyFS, [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>>> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }

    static func urlRequest <HeadersFS> (
        url: URL.FormatStyle = .url,
        body: Data.JSONFormatStyle = .json,
        headers: HeadersFS
    ) -> Self where Self == HTTPURLResponse.DefaultFormatStyle<Data.JSONFormatStyle, HeadersFS> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }

    static func urlRequest (
        url: URL.FormatStyle = .url,
        body: Data.JSONFormatStyle = .json,
        headers: [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>> = .dictionary()
    ) -> Self where Self == HTTPURLResponse.DefaultFormatStyle<Data.JSONFormatStyle, [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>>> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }
}

extension AnyFormatStyle {
    static func urlRequest <BodyFS, HeadersFS> (
        url: URL.FormatStyle = .url,
        body: BodyFS,
        headers: HeadersFS
    ) -> HTTPURLResponse.DefaultFormatStyle<BodyFS, HeadersFS> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }

    static func urlRequest <BodyFS> (
        url: URL.FormatStyle = .url,
        body: BodyFS,
        headers: [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>> = .dictionary()
    ) -> HTTPURLResponse.DefaultFormatStyle<BodyFS, [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>>> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }

    static func urlRequest <HeadersFS> (
        url: URL.FormatStyle = .url,
        body: Data.JSONFormatStyle = .json,
        headers: HeadersFS
    ) -> HTTPURLResponse.DefaultFormatStyle<Data.JSONFormatStyle, HeadersFS> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }

    static func urlRequest (
        url: URL.FormatStyle = .url,
        body: Data.JSONFormatStyle = .json,
        headers: [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>> = .dictionary()
    ) -> HTTPURLResponse.DefaultFormatStyle<Data.JSONFormatStyle, [AnyHashable: Any].DefaultFormatStyle<String.InterpolationFormatStyle<AnyHashable>, String.InterpolationFormatStyle<Any>>> {
        .init(
            url: url,
            body: body,
            headers: headers
        )
    }
}
