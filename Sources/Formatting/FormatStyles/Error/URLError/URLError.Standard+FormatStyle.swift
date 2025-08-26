import Foundation

public extension FormatStyle {
    static func urlError <UserInfoFS> (
        url: URL.FormatStyle = .url,
        userInfo: UserInfoFS
    ) -> Self
    where Self == URLError.StandardFormatStyle<UserInfoFS> {
        .init(
            url: url,
            userInfo: userInfo
        )
    }

    static func urlError (
        url: URL.FormatStyle = .url,
        userInfo: DictionaryDefaultFormatStyle<String, Any> = .dictionary()
    ) -> Self
    where Self == URLErrorDefaultFormatStyle {
        .init(
            url: url,
            userInfo: userInfo
        )
    }
}

public extension AnyFormatStyle {
    static func urlError <UserInfoFS> (
        url: URL.FormatStyle = .url,
        userInfo: UserInfoFS
    ) -> URLError.StandardFormatStyle<UserInfoFS> {
        .init(
            url: url,
            userInfo: userInfo
        )
    }

    static func urlError (
        url: URL.FormatStyle = .url,
        userInfo: DictionaryDefaultFormatStyle<String, Any> = .dictionary()
    ) -> URLErrorDefaultFormatStyle {
        .init(
            url: url,
            userInfo: userInfo
        )
    }
}
