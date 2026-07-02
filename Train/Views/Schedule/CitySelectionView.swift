//
//  CitySelectionView.swift
//  Train
//

import SwiftUI

struct CitySelectionView: View {
    @State private var selectedCityModel: City?
    @Binding var selectedStation: SelectedStation?
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    @StateObject
    private var viewModel = CitySelectionViewModel(
        service: AppContainer.shared.allStationsService
    )

    private var filteredStations: [Station] {
        guard let city = selectedCityModel else { return [] }

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
                .frame(height: 36)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.top, 12)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        if viewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView()
                                    .tint(.white)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, minHeight: 300)
                        }
                        else if selectedCityModel == nil {

                            if filteredCities.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("Город не найден")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24, weight: .bold))
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.6)

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
                        else {

                            if filteredStations.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("Станция не найдена")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24, weight: .bold))
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.6)

                            } else {
                                ForEach(filteredStations) { station in
                                    Button {
                                        guard let city = selectedCityModel else { return }

                                        selectedStation = SelectedStation(
                                            title: station.title.contains("(")
                                                ? station.title
                                                : "\(city.name) (\(station.title))",
                                            code: station.code
                                        )

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
    CitySelectionView(selectedStation: .constant(nil))
}
