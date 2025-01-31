//
//  SelectorViewModelProtocol.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

@MainActor
protocol SelectorViewModelProtocol: ObservableObject {
    associatedtype Item: Hashable & Sendable
    
    var searchText: String { get set }
    var filteredItems: [Item] { get }
    var isDataLoaded : Bool { get }
    
    func displayName(for item: Item) -> String
}
