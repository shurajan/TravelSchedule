//
//  GenericSelectorViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI


final class SelectorViewModel<Item: Hashable & Sendable>: SelectorViewModelProtocol {
    @Published var searchText: String = ""
    @Published var allItems: [Item] = []
    @Published var isDataLoaded = false
    
    private let nameKeyPath: KeyPath<Item, String>
    
    var filteredItems: [Item] {
        guard !searchText.isEmpty else {
            return allItems
        }
        return allItems.filter {
            $0[keyPath: nameKeyPath]
                .lowercased()
                .contains(searchText.lowercased())
        }
    }
    
    init(allItems: [Item], nameKeyPath: KeyPath<Item, String>) {
        self.allItems = allItems
        self.nameKeyPath = nameKeyPath
        self.isDataLoaded = true
    }
    
    init(asyncItems: @escaping () async -> [Item], nameKeyPath: KeyPath<Item, String>) {
        self.nameKeyPath = nameKeyPath
        Task {
            let items = await asyncItems()
            self.allItems = items
            self.isDataLoaded = true
        }
    }
    
    func displayName(for item: Item) -> String {
        return item[keyPath: nameKeyPath]
    }
}
