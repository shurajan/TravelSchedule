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
    
    @State private var viewState: ViewState = .loading
    
    var body: some View {
        VStack(spacing: 0) {
            topBar()
            searchBar()
            contentView()
        }
        .background(theme.backgroundColor)
        .onAppear {
            updateViewState()
        }
        .onChange(of: viewModel.filteredItems) { _ in
            updateViewState()
        }
        .onChange(of: viewModel.isDataLoaded) { _ in
            updateViewState()
        }
    }
    
    // MARK: - Top Bar
    @ViewBuilder
    private func topBar() -> some View {
        HStack {
            backButton()
            
            Spacer()
            
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(theme.textColor)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 44)
        .background(theme.backgroundColor)
    }
    
    // MARK: - Search Bar
    @ViewBuilder
    private func searchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(viewModel.searchText.isEmpty ? AppColors.gray.color : theme.textColor)
                .padding(.leading, 8)
            
            TextField(
                "",
                text: $viewModel.searchText,
                prompt: Text("Введите запрос")
                    .foregroundColor(AppColors.gray.color)
            )
            .foregroundColor(theme.textColor)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            .frame(height: 36)
        }
        .background(theme.searchFieldBackgroundColor)
        .cornerRadius(10)
        .padding()
    }
    
    // MARK: - Content
    @ViewBuilder
    private func contentView() -> some View {
        switch viewState {
        case .loading:
            Spacer()
                .overlay {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: theme.textColor))
                }
            
        case .success:
            listView()
            
        case .empty:
            Spacer()
            Text(notification)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(theme.textColor)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func listView() -> some View {
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
    
    // MARK: - Back Button
    @ViewBuilder
    private func backButton() -> some View {
        Button {
            viewModel.searchText = ""
            path.removeLast()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(theme.textColor)
        }
    }
    
    // MARK: - Logic
    private func updateViewState() {
        if viewModel.isDataLoaded {
            viewState = viewModel.filteredItems.isEmpty ? .empty : .success
        } else {
            viewState = .loading
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
