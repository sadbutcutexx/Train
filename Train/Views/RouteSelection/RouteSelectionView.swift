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

            VStack(spacing: 12) {

                // Header (как ты просил — сверху станции)
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(fromStation.title)")
                    Text("↓")
                        .opacity(0.6)
                    Text("\(toStation.title)")
                }
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 8)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView().tint(.white)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.routes, id: \.self) { segment in
                                RouteCard(segment: segment)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    }
                }
            }
        }
        .task {
            await viewModel.load(
                from: fromStation.cityCode,
                to: toStation.cityCode
            )
        }
    }
}

#Preview {
}
