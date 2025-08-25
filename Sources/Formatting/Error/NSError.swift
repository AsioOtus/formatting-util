import Foundation

extension NSError {
    public struct DefaultFormatStyle<UserInfoFS>: FormatStyle
    where
    UserInfoFS: FormatStyle,
    UserInfoFS.FormatInput == [String: Any],
    UserInfoFS.FormatOutput == String
    {
        public let userInfoFormatStyle: UserInfoFS

        public init (
            userInfoFormatStyle: UserInfoFS
        ) {
            self.userInfoFormatStyle = userInfoFormatStyle
        }

        public func format (_ error: NSError) -> String {
            var components: [String] = []

            components.append("Domain: \(error.domain)")
            components.append("Code: \(error.code)")

            if !error.localizedDescription.isEmpty {
                components.append("Description: \(error.localizedDescription)")
            }

            if let reason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String {
                components.append("Reason: \(reason)")
            }

            if let suggestion = error.userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String {
                components.append("Recovery: \(suggestion)")
            }

            if !error.userInfo.isEmpty {
                components.append("User info: \(userInfoFormatStyle.format(error.userInfo))")
            }

            return components.joined(separator: "\n")
        }
    }
}

public extension FormatStyle {
    static func nsError <UserInfoFS> (userInfo: UserInfoFS) -> Self
    where
    UserInfoFS: FormatStyle,
    Self == NSError.DefaultFormatStyle<UserInfoFS>
    {
        .init(userInfoFormatStyle: userInfo)
    }
}

public extension AnyFormatStyle {
    static func nsError <UserInfoFS> (userInfo: UserInfoFS) -> NSError.DefaultFormatStyle<UserInfoFS>
    where
    UserInfoFS: FormatStyle
    {
        .init(userInfoFormatStyle: userInfo)
    }
}
