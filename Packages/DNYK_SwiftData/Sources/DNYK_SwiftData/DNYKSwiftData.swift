// The Swift Programming Language
// https://docs.swift.org/swift-book
import DNYK_Core
import SwiftData

public struct DNYKSwiftData {
    public static func service(inMemory: Bool = false) -> DNYKService {
        do {
            let configuration = ModelConfiguration(
                isStoredInMemoryOnly: inMemory
            )
            
            let modelContainer: ModelContainer = try ModelContainer(
                for: SDCategoryModel.self, SDCategoryGroupModel.self,
                configurations: configuration
            )
            let localCategoryRepository = SDCategoryDataSource(container: modelContainer)
            return DefaultDNYKService(transactionRepository: SDTransactionDataSource(), localCategoryRepository: localCategoryRepository)
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
}
