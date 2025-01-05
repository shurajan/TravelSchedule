//
//  SelectorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct SelectorView<ViewModel: SelectorViewModelProtocol>: View {
    
    let title: String
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Введите запрос", text: $viewModel.searchText)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 8)
                
                List {
                    ForEach(viewModel.filteredItems, id: \.self) { item in
                        Button(action: {
                            viewModel.didSelectItem(item)
                        }) {
                            HStack {
                                Text(item)
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
                        viewModel.goBack()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

// MARK: - Превью
struct SelectorView_Previews: PreviewProvider {
    @StateObject static var mockViewModel = CitySelectorViewModel()
    
    static var previews: some View {
        SelectorView(title: "Выбор города",
                     viewModel: mockViewModel)
    }
}