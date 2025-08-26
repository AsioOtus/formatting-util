import Foundation

public typealias URLRequestDefaultFormatStyle = URLRequest.StandardFormatStyle<
    OptionalCompositeFormatStyle<Data, String>,
    DictionaryDefaultFormatStyle<String, String>
>

extension URLRequest {
    public struct StandardFormatStyle<BodyFS, HeadersFS>: FormatStyle, Codable, Hashable
    where
    BodyFS: FormatStyle,
    BodyFS.FormatInput == Data,
    BodyFS.FormatOutput == String?,
    HeadersFS: FormatStyle,
    HeadersFS.FormatInput == [String: String],
    HeadersFS.FormatOutput == String
    {
        public let options: Options

        public let urlFormatStyle: URL.FormatStyle
        public let bodyFormatStyle: BodyFS
        public let headersFormatStyle: HeadersFS

        public init (
            url: URL.FormatStyle,
            headers: HeadersFS,
            body: BodyFS
        ) {
            self.options = .init()
            self.urlFormatStyle = url
            self.bodyFormatStyle = body
            self.headersFormatStyle = headers
        }

		private init (
            options: Options,
            url: URL.FormatStyle,
            headers: HeadersFS,
            body: BodyFS
		) {
            self.options = options
            self.urlFormatStyle = url
			self.bodyFormatStyle = body
			self.headersFormatStyle = headers
		}
		
		public func format (_ urlRequest: URLRequest) -> String {
			var components = [String]()

            prefix(&components)
            requestLine(urlRequest, &components)

            guard !options.isRequestLineOnly else {
                return components.joined(separator: "\n")
            }

            headers(urlRequest, &components)
            body(urlRequest, &components)

			return components.joined(separator: "\n")
		}

        private func prefix (_ components: inout [String]) {
            if let prefix = options.prefix {
                components.append(prefix)
                components.append("")
            }
        }

        private func requestLine (_ urlRequest: URLRequest, _ components: inout [String]) {
            var method = urlRequest.httpMethod
            if options.usePlaceholders {
                method = method.ifNil("No method").ifEmpty("No method")
            }

            var url = urlRequest.url?.formatted(urlFormatStyle)
            if options.usePlaceholders {
                url = url?.ifEmpty("No URL") ?? noValue("No URL")
            }

            let requestLine = [method, url]
                .compactMap{ $0 }
                .filter { $0 != "" }
                .joined(separator: " ")

            components.append(requestLine)
        }

        private func headers (_ urlRequest: URLRequest, _ components: inout [String]) {
            if let headers = urlRequest.allHTTPHeaderFields {
                let headers = headersFormatStyle.format(headers)

                if options.usePlaceholders {
                    let headers = headers.ifEmpty("No headers")
                    components.append("")
                    components.append(headers)
                }
            } else if options.usePlaceholders {
                components.append("")
                components.append(noValue("No headers"))
            }
        }

        private func body (_ urlRequest: URLRequest, _ components: inout [String]) {
            if let body = urlRequest.httpBody {
                let body = bodyFormatStyle.format(body)

                if options.usePlaceholders {
                    let body = body
                        .ifNil("Body representation is nil")
                        .ifEmpty("Body representation is empty")

                    components.append("")
                    components.append(body)
                }
            } else if options.usePlaceholders {
                components.append("")
                components.append(noValue("No body"))
            }
        }
	}
}

public extension URLRequest.StandardFormatStyle {
    func options (_ options: Options) -> Self {
        .init(
            options: options,
            url: urlFormatStyle,
            headers: headersFormatStyle,
            body: bodyFormatStyle
        )
    }

    func prefix (_ prefix: String) -> Self {
        .init(
            options: .init(
                prefix: prefix,
                isRequestLineOnly: options.isRequestLineOnly,
                usePlaceholders: options.usePlaceholders
            ),
            url: urlFormatStyle,
            headers: headersFormatStyle,
            body: bodyFormatStyle
        )
    }

    func isRequestLineOnly (_ isRequestLineOnly: Bool) -> Self {
        .init(
            options: .init(
                prefix: options.prefix,
                isRequestLineOnly: isRequestLineOnly,
                usePlaceholders: options.usePlaceholders
            ),
            url: urlFormatStyle,
            headers: headersFormatStyle,
            body: bodyFormatStyle
        )
    }

    func usePlaceholders (_ usePlaceholders: Bool) -> Self {
        .init(
            options: .init(
                prefix: options.prefix,
                isRequestLineOnly: options.isRequestLineOnly,
                usePlaceholders: usePlaceholders
            ),
            url: urlFormatStyle,
            headers: headersFormatStyle,
            body: bodyFormatStyle
        )
    }
}
