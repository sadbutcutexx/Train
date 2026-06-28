//
//  CitySelectionView.swift
//  Train
//

import SwiftUI

struct CitySelectionView: View {
    @Binding var selectedCity: String
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    private var filteredCities: [City] {
        if searchText.isEmpty {
            return cities
        }

        return cities.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ZStack {
            Color("Black")
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("Введите запрос", text: $searchText)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .frame(height: 36   )
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.top, 12)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredCities) { city in
                            NavigationLink {
                                StationSelectionView(
                                    city: city,
                                    selectedCity: $selectedCity
                                )
                            } label: {
                                HStack {
                                    Text(city.name)
                                        .font(.system(size: 17))
                                        .foregroundStyle(.white)

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 60)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    CitySelectionView(selectedCity: .constant(""))
}
