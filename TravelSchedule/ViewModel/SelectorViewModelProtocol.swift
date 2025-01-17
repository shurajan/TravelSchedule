//
//  SelectorViewModelProtocol.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

protocol SelectorViewModelProtocol: ObservableObject {
    associatedtype Item: Hashable
    
    var searchText: String { get set }
    var filteredItems: [Item] { get }
    
    func displayName(for item: Item) -> String
}
