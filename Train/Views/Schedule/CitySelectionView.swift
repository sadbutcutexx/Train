//
//  CitySelectionView.swift
//  Train
//

import SwiftUI

struct CitySelectionView: View {
    @State private var selectedCityModel: City?
    @Binding var selectedCity: String
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    @StateObject
    private var viewModel = CitySelectionViewModel(
        service: AppContainer.shared.allStationsService
    )
    
    private var filteredStations: [Station] {

        guard let city = selectedCityModel else {
            return []
        }

        if searchText.isEmpty {
            return city.stations
        }

        return city.stations.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var filteredCities: [City] {

        if searchText.isEmpty {
            return viewModel.cities
        }

        return viewModel.cities.filter {
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
                        if let city = selectedCityModel {
                            ForEach(filteredStations) { station in
                                Button {
                                    if station.title.contains("(") {
                                        selectedCity = station.title
                                    } else {
                                        selectedCity = "\(city.name) (\(station.title))"
                                    }

                                    dismiss()
                                } label: {
                                    HStack {
                                        Text(station.title)
                                            .font(.system(size: 17))
                                            .foregroundStyle(.white)

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.white)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .padding(.horizontal, 16)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }

                        } else {
                            ForEach(filteredCities) { city in
                                Button {
                                    selectedCityModel = city
                                    searchText = ""
                                } label: {
                                    HStack {
                                        Text(city.name)
                                            .font(.system(size: 17))
                                            .foregroundStyle(.white)
                                            .font(.system(size: 17))
                                            .foregroundStyle(.white)

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.white)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .padding(.horizontal, 16)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }

                        }
                    }
                }
            }
        }
        .navigationTitle(selectedCityModel?.name ?? "Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if selectedCityModel != nil {
                        selectedCityModel = nil
                        searchText = ""
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    CitySelectionView(selectedCity: .constant(""))
}
