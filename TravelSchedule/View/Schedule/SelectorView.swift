//
//  SelectorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct SelectorView<ViewModel: SelectorViewModelProtocol>: View {
    @EnvironmentObject var theme: Theme
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
                        .foregroundColor(viewModel.searchText.isEmpty ? AppColors.gray.color : theme.textColor)
                        .padding(.leading, 8)
                    
                    TextField("",
                              text: $viewModel.searchText,
                              prompt: Text("Введите запрос")
                                           .foregroundColor(AppColors.gray.color))
                        .foregroundColor(theme.textColor)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .frame(height: 36)
                }
                .background(theme.searchFieldBackgroundColor)
                .cornerRadius(10)
                .padding()
                
                if viewModel.filteredItems.isEmpty {
                    Spacer()
                    Text(notification)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(theme.textColor)
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
                                        .foregroundColor(theme.textColor)
                                        .padding(.leading, 16)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(theme.textColor)
                                        .padding(.trailing, 16)
                                }
                                .frame(height: 60)
                            }
                            .background(theme.backgroundColor)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
            .background(theme.backgroundColor)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.searchText = "" 
                        path.removeLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(theme.textColor)
                    }
                }
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = UIColor(theme.backgroundColor)
            
            appearance.shadowColor = .clear
            
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(theme.textColor),
                .font: UIFont.systemFont(ofSize: 17, weight: .bold)
            ]
            
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(theme.textColor)
            ]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            UINavigationBar.appearance().tintColor = UIColor(theme.textColor)
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
    .environmentObject(Theme())
}
