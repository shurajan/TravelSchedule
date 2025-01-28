//
//  DataDownloader.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 28.01.2025.
//

actor DataDownloader<TransformerType: Transformer>: DataDownloaderProtocol
where TransformerType.Input: Sendable, TransformerType.Output: Sendable {
    typealias Item = TransformerType.Output
    
    private var items = [Item]()
    private let apiService: () async throws -> [TransformerType.Input]?
    private let transformer: TransformerType
    
    init(
        apiService: @escaping () async throws -> [TransformerType.Input]?,
        transformer: TransformerType
    ) {
        self.apiService = apiService
        self.transformer = transformer
    }
    
    func fetchData() async throws {
        do {
            let rawItems = try await apiService() ?? []
        
            items = rawItems.compactMap { rawItem in
                transformer.transform(rawItem)
            }
        } catch {
            throw error
        }
    }
    
    func getItems() async -> [Item] {
        return items
    }
}
