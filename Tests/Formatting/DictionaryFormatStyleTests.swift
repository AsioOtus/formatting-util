import Testing

@testable import FormattingUtil

struct DictionaryFormatStyleTests {
    @Test
    func plain () {
        // Given
        let sample = [
            "1": "A",
            "2": "B",
        ]
        let sut = [String: String].DefaultFormatStyle(
            key: .interpolation(),
            value: .interpolation()
        )

        // When
        let formattedSample = sut.format(sample)

        // Then
        let expected = [
            """
            1: A
            2: B
            """,
            """
            2: B
            1: A
            """
        ]
        #expect(expected.contains(formattedSample))
    }

    @Test
    func pretty () {
        // Given
        let sample = [
            "1": "A",
            "2": "B",
        ]
        let sut = [String: String].DefaultFormatStyle(
            key: .interpolation(),
            value: .interpolation()
        )
        .pretty()

        // When
        let formattedSample = sut.format(sample)

        // Then
        let expected = [
            """
            [
                1: A
                2: B
            ]
            """,
            """
            [
                2: B
                1: A
            ]
            """
        ]
        #expect(expected.contains(formattedSample))
    }
}
