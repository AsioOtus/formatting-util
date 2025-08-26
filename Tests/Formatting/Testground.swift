import Foundation
import Testing

@testable import FormattingUtil

struct Testground {
    @Test
    func main () {
        func test <FS: FormatStyle> (_ f: FS) where FS.FormatInput == URLResponse, FS.FormatOutput == String {

        }

        test(.cast(to: .httpUrlResponse()).or("qwe"))
    }
}
