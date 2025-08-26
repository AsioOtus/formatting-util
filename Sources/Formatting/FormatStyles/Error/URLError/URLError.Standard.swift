import Foundation

public typealias URLErrorDefaultFormatStyle = URLError.StandardFormatStyle<
    DictionaryDefaultFormatStyle<String, Any>
>

extension URLError {
    public struct StandardFormatStyle<UserInfoFS>: FormatStyle
    where
    UserInfoFS: FormatStyle,
    UserInfoFS.FormatInput == [String: Any],
    UserInfoFS.FormatOutput == String
    {
        public let urlFormatStyle: URL.FormatStyle
        public let userInfoFormatStyle: UserInfoFS

        public init (
            url: URL.FormatStyle,
            userInfo: UserInfoFS
        ) {
            self.urlFormatStyle = url
            self.userInfoFormatStyle = userInfo
        }

        public func format (_ urlError: URLError) -> String {
            var components: [String] = []

            switch urlError.code {
            case .notConnectedToInternet: components.append("No Internet connection")
            case .timedOut:               components.append("Request timed out")
            case .cannotFindHost:         components.append("Cannot find host")
            case .cannotConnectToHost:    components.append("Cannot connect to host")
            case .networkConnectionLost:  components.append("Network connection lost")
            case .dnsLookupFailed:        components.append("DNS lookup failed")
            case .secureConnectionFailed: components.append("Secure connection failed")
            case .badServerResponse:      components.append("Bad server response")
            default:                      components.append(urlError.localizedDescription)
            }

            components.append("Code: \(urlError.errorCode) (\(urlError.code))")

            if let url = urlError.failingURL {
                components.append("URL: \(url.absoluteString)")
            }

            if !urlError.localizedDescription.isEmpty {
                components.append("System: \(urlError.localizedDescription)")
            }

            if !urlError.userInfo.isEmpty {
                components.append("User info: \(userInfoFormatStyle.format(urlError.userInfo))")
            }

            return components.joined(separator: "\n")
        }
    }
}
