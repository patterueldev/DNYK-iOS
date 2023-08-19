// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct DNYKCore {
    static var coreStrings: ICoreStrings = DefaultCoreStrings()
    
    public static func setCoreStrings(coreStrings: ICoreStrings) {
        self.coreStrings = coreStrings
    }
}
