//
//  SelectorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct SelectorView<ViewModel: SelectorViewModelProtocol>: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @Binding var path: [ViewPath]
    
    let title: String
    @ObservedObject var viewModel: ViewModel
    
    let onItemTap: (ViewModel.Item) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(viewModel.searchText.isEmpty ? ColorPalette.gray.color : ColorPalette.black(day: true).color)
                        .padding(.leading, 8)
                    
                    TextField("Введите запрос", text: $viewModel.searchText)
                        .foregroundColor(ColorPalette.black(day: true).color)
                        .frame(height: 36)

                }
                .background(ColorPalette.lightGray.color)
                .cornerRadius(10)
                .padding()
                
                List {
                    ForEach(viewModel.filteredItems, id: \.self) { item in
                        Button(action: {
                            onItemTap(item)
                        }) {
                            HStack {
                                Text(viewModel.displayName(for: item))
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(themeViewModel.accentColor)
                                    .padding(.leading, 16)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(themeViewModel.accentColor)
                                    .padding(.trailing, 16)
                            }
                            .frame(height: 60)
                        }
                        .background(themeViewModel.backgroundColor)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.plain)
            }
            .background(themeViewModel.backgroundColor)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(themeViewModel.accentColor)
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
