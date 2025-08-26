import Foundation

public extension FormatStyle {
    static func urlResponse <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS
    ) -> Self where Self == URLResponse.StandardFormatStyle<HeadersFS> {
        .init(
            url: url,
            headers: headers
        )
    }

    static func urlResponse (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<AnyHashable, Any> = .dictionary()
    ) -> Self where Self == URLResponseDefaultFormatStyle {
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
    ) -> URLResponse.StandardFormatStyle<HeadersFS> {
        .init(
            url: url,
            headers: headers
        )
    }

    static func urlResponse (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<AnyHashable, Any> = .dictionary()
    ) -> URLResponseDefaultFormatStyle {
        .init(
            url: url,
            headers: headers
        )
    }
}
