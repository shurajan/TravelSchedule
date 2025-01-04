//
//  CitySelectorViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//
import SwiftUI

final class CitySelectorViewModel: SelectorViewModelProtocol {
    @Published var searchText: String = ""
    
    private let allItems: [String] = [
        "Москва",
        "Санкт-Петербург",
        "Сочи",
        "Горный воздух",
        "Краснодар",
        "Казань",
        "Омск"
    ]
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else {
            return allItems
        }
        return allItems.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    func didSelectItem(_ item: String) {
        print("Выбран элемент: \(item)")
    }
    
    func goBack() {
        print("Нажата кнопка 'Назад'")
    }
}
