import Foundation

public extension FormatStyle {
    static func httpUrlResponse <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS
    ) -> Self where Self == HTTPURLResponse.StandardFormatStyle<HeadersFS> {
        .init(
            url: url,
            headers: headers
        )
    }

    static func httpUrlResponse (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<AnyHashable, Any> = .dictionary()
    ) -> Self
    where Self == HTTPURLResponseDefaultFormatStyle {
        .init(
            url: url,
            headers: headers
        )
    }
}

public extension AnyFormatStyle {
    static func httpUrlResponse <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS
    ) -> HTTPURLResponse.StandardFormatStyle<HeadersFS> {
        .init(
            url: url,
            headers: headers
        )
    }

    static func httpUrlResponse (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<AnyHashable, Any> = .dictionary()
    ) -> HTTPURLResponseDefaultFormatStyle {
        .init(
            url: url,
            headers: headers
        )
    }
}
