func noValue (_ message: String) -> String {
    "[\(message)]"
}

extension Optional {
    func ifNil (_ message: String) -> String {
        map { "\($0)" } ?? noValue(message)
    }
}

extension String {
    func ifEmpty (_ message: String) -> String {
        isEmpty ? noValue(message) : self
    }
}
