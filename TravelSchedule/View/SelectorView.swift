//
//  SelectorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct SelectorView<ViewModel: SelectorViewModelProtocol>: View {
    @Binding var path: [ViewPath]
    @Binding var item: String
    
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
                        .frame(height: 36)
                }
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .padding()
                
                List {
                    ForEach(viewModel.filteredItems, id: \.self) { item in
                        Button(action: {
                            self.item = item
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

// MARK: - Превью
struct SelectorView_Previews: PreviewProvider {
    @StateObject static var mockViewModel = CitySelectorViewModel()
    
    static var previews: some View {
        SelectorView(path: .constant([]), item: .constant("Москва"), title: "Выбор города",
                     viewModel: mockViewModel)
    }
}
