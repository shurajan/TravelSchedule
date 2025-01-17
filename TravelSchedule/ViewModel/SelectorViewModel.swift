//
//  GenericSelectorViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

final class SelectorViewModel<Item: Hashable>: SelectorViewModelProtocol {
    @Published var searchText: String = ""
    
    private let allItems: [Item]
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
    }
    
    func displayName(for item: Item) -> String {
        return item[keyPath: nameKeyPath]
    }
}
