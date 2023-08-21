// The Swift Programming Language
// https://docs.swift.org/swift-book
import DNYK_Core
import SwiftData

public struct DNYKSwiftData {
    public static func service(inMemory: Bool = false) -> DNYKService {
        do {
            let types: [any PersistentModel.Type] = [
                SDCategoryModel.self,
                SDCategoryGroupModel.self,
            ]
            let modelContainer: ModelContainer
            if inMemory {
                modelContainer = try ModelContainer(for: types, ModelConfiguration(inMemory: true))
            } else {
                modelContainer = try ModelContainer(for: types)
            }
            let localCategoryRepository = SDCategoryDataSource(container: modelContainer)
            return DefaultDNYKService(transactionRepository: SDTransactionDataSource(), localCategoryRepository: localCategoryRepository)
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
}
