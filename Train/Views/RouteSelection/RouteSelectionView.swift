//
//  RouteSelectionView.swift
//  Train
//

import SwiftUI

struct RouteSelectionView: View {

    let fromStation: SelectedStation
    let toStation: SelectedStation

    @StateObject private var viewModel: RouteSelectionViewModel
    @State private var filters = RouteFilters()
    @Environment(\.dismiss) private var dismiss

    init(fromStation: SelectedStation, toStation: SelectedStation) {
        self.fromStation = fromStation
        self.toStation = toStation

        _viewModel = StateObject(
            wrappedValue: RouteSelectionViewModel(
                service: AppContainer.shared.schedualBetweenStationsService
            )
        )
    }
    
    private var filteredRoutes: [Components.Schemas.Segment] {
        let baseRoutes = viewModel.showingAlternatives ? viewModel.alternativeRoutes : viewModel.routes
        
        return baseRoutes.filter { segment in
            guard let departureStr = segment.departure,
                  let departureDate = ISO8601DateFormatter().date(from: departureStr) else {
                return true
            }
            
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: departureDate)
            
            var matchesTime = false
            if filters.morningSelected && hour >= 6 && hour < 12 {
                matchesTime = true
            }
            if filters.daySelected && hour >= 12 && hour < 18 {
                matchesTime = true
            }
            if filters.eveningSelected && hour >= 18 && hour < 24 {
                matchesTime = true
            }
            if filters.nightSelected && (hour >= 0 && hour < 6) {
                matchesTime = true
            }
            
            return matchesTime
        }
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(fromStation.title) → \(toStation.title)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color("TextColor"))
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 20)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView().tint(Color("TextColor"))
                    Spacer()
                } else if viewModel.routes.isEmpty && viewModel.alternativeRoutes.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 48))
                            .foregroundStyle(Color("TextColor").opacity(0.7))
                        
                        Text("Рейсы не найдены")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("TextColor"))
                    }
                    Spacer()
                } else if viewModel.routes.isEmpty && !viewModel.alternativeRoutes.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color("TextColor"))
                    Spacer()
                } else {
                    ZStack(alignment: .bottom) {
                        ScrollView {
                            VStack(spacing: 12) {
                                let displayedRoutes = filteredRoutes
                                
                                if viewModel.showingAlternatives {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack(spacing: 8) {
                                            Image(systemName: "info.circle.fill")
                                                .foregroundStyle(.blue)
                                            Text("Альтернативные маршруты")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundStyle(Color("TextColor"))
                                        }
                                        
                                        Text("Поезда отправляются с других станций в выбранных городах")
                                            .font(.system(size: 13))
                                            .foregroundStyle(Color("TextColor").opacity(0.7))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.blue.opacity(0.15))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                
                                if displayedRoutes.isEmpty {
                                    VStack(spacing: 12) {
                                        Image(systemName: "line.3.horizontal.decrease.circle")
                                            .font(.system(size: 48))
                                            .foregroundStyle(Color("TextColor").opacity(0.7))
                                        
                                        Text("Нет рейсов по выбранным фильтрам")
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundStyle(Color("TextColor"))
                                            .multilineTextAlignment(.center)
                                        
                                        Text("Попробуйте изменить параметры поиска")
                                            .font(.system(size: 14))
                                            .foregroundStyle(Color("TextColor").opacity(0.7))
                                    }
                                    .padding(.vertical, 60)
                                } else {
                                    ForEach(displayedRoutes, id: \.self) { segment in
                                        RouteCard(segment: segment)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 100)
                        }
                        
                        NavigationLink {
                            RouteFilterView(filters: $filters)
                        } label: {
                            Text("Уточнить время")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .toolbarBackground(Color("BackgroundColor"), for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color("TextColor"))
                        .font(.system(size: 20, weight: .semibold))
                }
            }
        }
        .task {
            await viewModel.load(
                fromCityCode: fromStation.cityCode,
                toCityCode: toStation.cityCode,
                fromStationCode: fromStation.code,
                toStationCode: toStation.code,
                fromStationTitle: fromStation.stationTitle,
                toStationTitle: toStation.stationTitle
            )
        }
    }
}

#Preview {
}
