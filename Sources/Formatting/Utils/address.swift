enum Address {
    static func get (_ object: AnyObject) -> String {
        Unmanaged.passUnretained(object).toOpaque().debugDescription
    }
}
