//
//  SelectorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct SelectorView<ViewModel: SelectorViewModelProtocol>: View {
    @Binding var path: [ViewPath]
    
    let title: String
    @ObservedObject var viewModel: ViewModel
    
    let onItemTap: (ViewModel.Item) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Введите запрос", text: $viewModel.searchText)
                        .foregroundColor(.gray)
                        .frame(height: 36)
                }
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .padding()
                
                List {
                    ForEach(viewModel.filteredItems, id: \.self) { item in
                        Button(action: {
                            onItemTap(item)
                        }) {
                            HStack {
                                Text(viewModel.displayName(for: item))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {

    let mockCities: [City] = [
        City(name: "Москва", stations: [
            Station(name: "Ленинградский вокзал", code: "MOW001"),
            Station(name: "Казанский вокзал", code: "MOW002")
        ]),
        City(name: "Санкт-Петербург", stations: [
            Station(name: "Московский вокзал", code: "SPB001")
        ]),
        City(name: "Сочи", stations: [
            Station(name: "Адлер", code: "SOC001")
        ]),
        City(name: "Краснодар", stations: [
            Station(name: "Краснодар-1", code: "KRD001")
        ])
    ]
    
    let viewModel = SelectorViewModel<City>(
        allItems: mockCities,
        nameKeyPath: \.name
    )
    
    return SelectorView(
        path: .constant([]),
        title: "Выбор города",
        viewModel: viewModel,
        onItemTap: { city in
            print("Выбран город:", city.name)
        }
    )
}
