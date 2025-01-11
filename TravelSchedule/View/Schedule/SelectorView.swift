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
    let notification: String
    @ObservedObject var viewModel: ViewModel
    
    let onItemTap: (ViewModel.Item) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(viewModel.searchText.isEmpty ? ColorPalette.gray.color : themeViewModel.textColor)
                        .padding(.leading, 8)
                    
                    TextField("",
                              text: $viewModel.searchText,
                              prompt: Text("Введите запрос")
                                           .foregroundColor(ColorPalette.gray.color))
                        .foregroundColor(themeViewModel.textColor)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .frame(height: 36)
                }
                .background(themeViewModel.searchFieldBackGroundColor)
                .cornerRadius(10)
                .padding()
                
                if viewModel.filteredItems.isEmpty {
                    Spacer()
                    Text(notification)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(themeViewModel.textColor)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.filteredItems, id: \.self) { item in
                            Button {
                                onItemTap(item)
                            } label: {
                                HStack {
                                    Text(viewModel.displayName(for: item))
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(themeViewModel.textColor)
                                        .padding(.leading, 16)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(themeViewModel.textColor)
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
                
            }
            .background(themeViewModel.backgroundColor)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        path.removeLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(themeViewModel.textColor)
                    }
                }
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = UIColor(themeViewModel.backgroundColor)
            
            appearance.shadowColor = .clear
            
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(themeViewModel.textColor),
                .font: UIFont.systemFont(ofSize: 17, weight: .bold)
            ]
            
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(themeViewModel.textColor)
            ]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            UINavigationBar.appearance().tintColor = UIColor(themeViewModel.textColor)
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
        notification: "Город не найден",
        viewModel: viewModel
    ) { city in
        print("Выбран город:", city.name)
    }
    .environmentObject(ThemeViewModel()) // Подставьте реальный ThemeViewModel
}
