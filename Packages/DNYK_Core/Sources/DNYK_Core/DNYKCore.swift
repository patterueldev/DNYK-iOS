// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct DNYKCore {
    private(set) static var coreStrings: ICoreStrings = DefaultCoreStrings()
    
    public static func setCoreStrings(_ coreStrings: ICoreStrings) {
        self.coreStrings = coreStrings
    }
}
