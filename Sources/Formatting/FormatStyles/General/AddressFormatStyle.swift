import Foundation

public struct AddressFormatStyle <Input: AnyObject>: FormatStyle, Codable, Hashable {
    public init () { }

    public func format (_ value: Input) -> String {
        Address.get(value)
    }
}

public extension FormatStyle {
    static func address <Input> (_ inputType: Input.Type = Input.self) -> Self where Self == AddressFormatStyle<Input> {
        .init()
    }
}

public extension AnyFormatStyle {
    static func address <Input> (_ inputType: Input.Type = Input.self) -> AddressFormatStyle<Input> {
        .init()
    }
}
