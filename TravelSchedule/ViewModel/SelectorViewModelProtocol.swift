//
//  SelectorViewModelProtocol.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

protocol SelectorViewModelProtocol: ObservableObject {
    
    var searchText: String { get set }
    
    var filteredItems: [String] { get }
    
    func didSelectItem(_ city: String)
    
    func goBack()
}
