import Foundation

public extension FormatStyle {
    static func urlRequest <BodyFS, HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS,
        body: BodyFS
    ) -> Self
    where
    Self == URLRequest.StandardFormatStyle<BodyFS, HeadersFS> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }

    static func urlRequest <BodyFS> (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<String, String> = .dictionary(),
        body: BodyFS
    ) -> Self where Self == URLRequest.StandardFormatStyle<BodyFS, DictionaryDefaultFormatStyle<String, String>> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }

    static func urlRequest <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS,
        body: OptionalCompositeFormatStyle<Data, String> = .try(
            .json.eraseToAnyFormatStyle(),
            .text.eraseToAnyFormatStyle(),
            .base64.optional.eraseToAnyFormatStyle()
        )
    ) -> Self where Self == URLRequest.StandardFormatStyle<OptionalCompositeFormatStyle<Data, String>, HeadersFS> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }

    static func urlRequest (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<String, String> = .dictionary(),
        body: OptionalCompositeFormatStyle<Data, String> = .try(
            .json.eraseToAnyFormatStyle(),
            .text.eraseToAnyFormatStyle(),
            .base64.optional.eraseToAnyFormatStyle()
        )
    ) -> Self where Self == URLRequest.StandardFormatStyle<OptionalCompositeFormatStyle<Data, String>, DictionaryDefaultFormatStyle<String, String>> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }
}

public extension AnyFormatStyle {
    static func urlRequest <BodyFS, HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS,
        body: BodyFS
    ) -> URLRequest.StandardFormatStyle<BodyFS, HeadersFS> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }

    static func urlRequest <BodyFS> (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<String, String> = .dictionary(),
        body: BodyFS
    ) -> URLRequest.StandardFormatStyle<BodyFS, DictionaryDefaultFormatStyle<String, String>> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }

    static func urlRequest <HeadersFS> (
        url: URL.FormatStyle = .url,
        headers: HeadersFS,
        body: OptionalCompositeFormatStyle<Data, String> = .try(
            .json.eraseToAnyFormatStyle(),
            .text.eraseToAnyFormatStyle(),
            .base64.optional.eraseToAnyFormatStyle()
        )
    ) -> URLRequest.StandardFormatStyle<OptionalCompositeFormatStyle<Data, String>, HeadersFS> {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }

    static func urlRequest (
        url: URL.FormatStyle = .url,
        headers: DictionaryDefaultFormatStyle<String, String> = .dictionary(),
        body: OptionalCompositeFormatStyle<Data, String> = .try(
            .json.eraseToAnyFormatStyle(),
            .text.eraseToAnyFormatStyle(),
            .base64.optional.eraseToAnyFormatStyle()
        )
    ) -> URLRequestDefaultFormatStyle {
        .init(
            url: url,
            headers: headers,
            body: body
        )
    }
}
