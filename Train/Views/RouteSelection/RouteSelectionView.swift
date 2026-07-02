//
//  RouteSelectionView.swift
//  Train
//

import SwiftUI

struct RouteSelectionView: View {
    
    @StateObject var viewModel = RouteSelectionViewModel(
        service: AppContainer.shared.schedualBetweenStationsService
    )
    
    @Environment(\.dismiss) var dismiss

    let fromStation: SelectedStation
    let toStation: SelectedStation

    var body: some View {
        ZStack {
            Color("Black")
                .ignoresSafeArea()

            VStack {

                Text("\(fromStation.title) → \(toStation.title)")
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                if viewModel.isLoading {

                    ProgressView()
                        .tint(.white)

                } else {

                    Text("Найдено \(viewModel.routes.count) маршрутов")
                        .foregroundStyle(.white)
                }
            }
        }
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
        .task {
            await viewModel.load(
                from: fromStation.code,
                to: toStation.code
            )
        }
    }
}

#Preview {
    RouteSelectionView(
        fromStation: SelectedStation(
            title: "Москва (Ярославский вокзал)",
            code: "s2000001"
        ),
        toStation: SelectedStation(
            title: "Санкт-Петербург (Московский вокзал)",
            code: "s9602498"
        )
    )
}
