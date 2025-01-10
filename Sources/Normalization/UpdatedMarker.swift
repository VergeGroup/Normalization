/// A container that manages raw value to describe mark as updated.
public struct UpdatedMarker: Hashable, Sendable {

  private(set) public var value: UInt64 = 0

  public init() {}

  public mutating func increment() {
    value &+= 1
  }

}
