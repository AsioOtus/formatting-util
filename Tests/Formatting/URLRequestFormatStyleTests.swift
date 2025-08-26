import Foundation
import Testing

@testable import FormattingUtil

struct URLRequestFormatStyleTests {
    @Test("Placeholders – All – Enabled")
    func placeholders_all_enabled () {
        // Given
        let sut = URLRequest.StandardFormatStyle(
            url: .url,
            headers: .dictionary(),
            body: .base64.optional
        )

        var urlRequest = URLRequest(url: .init(string: "site.com")!)
        urlRequest.httpMethod = ""

        // When
        let formatted = sut.format(urlRequest)

        // Then
        let expected =
            """
            [No method] site.com
            
            [No headers]
            
            [No body]
            """

        #expect(formatted == expected)
    }

    @Test("Placeholders – All – Disabled")
    func placeholders_all_disabled () {
        // Given
        let sut = URLRequest.StandardFormatStyle(
            url: .url,
            headers: .dictionary(),
            body: .base64.optional
        )
            .usePlaceholders(false)

        var urlRequest = URLRequest(url: .init(string: "site.com")!)
        urlRequest.httpMethod = ""

        // When
        let formatted = sut.format(urlRequest)

        // Then
        let expected =
            """
            site.com
            """

        #expect(formatted == expected)
    }

    @Test("Headers")
    func headers () {
        let sut = URLRequest.StandardFormatStyle(
            url: .url,
            headers: .dictionary(),
            body: .base64.optional
        )

        var urlRequest = URLRequest(url: .init(string: "site.com")!)
        urlRequest.addValue("1", forHTTPHeaderField: "headerA")
        urlRequest.addValue("2", forHTTPHeaderField: "headerB")

        let formatted = sut.format(urlRequest)

        let expected = [
            """
            GET site.com
            
            headerA: 1
            headerB: 2
            
            [No body]
            """,
            """
            GET site.com
            
            headerB: 2
            headerA: 1
            
            [No body]
            """
        ]

        #expect(expected.contains(formatted))
    }
}
