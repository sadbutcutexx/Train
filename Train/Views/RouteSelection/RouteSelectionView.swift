//
//  RouteSelectionView.swift
//  Train
//

import SwiftUI

struct RouteSelectionView: View {

    let fromStation: SelectedStation
    let toStation: SelectedStation

    @StateObject private var viewModel: RouteSelectionViewModel

    init(fromStation: SelectedStation, toStation: SelectedStation) {
        self.fromStation = fromStation
        self.toStation = toStation

        _viewModel = StateObject(
            wrappedValue: RouteSelectionViewModel(
                service: AppContainer.shared.schedualBetweenStationsService
            )
        )
    }

    var body: some View {
        ZStack {
            Color("Black").ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(fromStation.title) → \(toStation.title)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 20)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView().tint(.white)
                    Spacer()
                } else if viewModel.routes.isEmpty && viewModel.alternativeRoutes.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 48))
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Text("Рейсы не найдены")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text("Попробуйте выбрать другие станции")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    Spacer()
                } else if viewModel.routes.isEmpty && !viewModel.alternativeRoutes.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "arrow.triangle.branch")
                            .font(.system(size: 48))
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Text("Нет прямых рейсов")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text("С выбранных станций нет рейсов.\nПоезда отправляются с других станций в этих городах.")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        Button {
                            viewModel.showingAlternatives = true
                        } label: {
                            Text("Показать альтернативные маршруты (\(viewModel.alternativeRoutes.count))")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.top, 8)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            let displayedRoutes = viewModel.showingAlternatives ? viewModel.alternativeRoutes : viewModel.routes
                            
                            if viewModel.showingAlternatives {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "info.circle.fill")
                                            .foregroundStyle(.blue)
                                        Text("Альтернативные маршруты")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Text("Поезда отправляются с других станций в выбранных городах")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.white.opacity(0.7))
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                            ForEach(displayedRoutes, id: \.self) { segment in
                                RouteCard(segment: segment)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 100)
                    }
                    
                    VStack(spacing: 0) {
                        Spacer()
                        
                        Button {
                        } label: {
                            Text("Уточнить время")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
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
