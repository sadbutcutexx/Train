//
//  ScheduleView.swift
//  Train
//

import SwiftUI

struct ScheduleView: View {

    @StateObject private var viewModel = ScheduleViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {

                    StoriesView()
                        .padding(.bottom, 44)

                    SearchCard(
                        fromStation: $viewModel.fromStation,
                        toStation: $viewModel.toStation
                    )

                    if viewModel.canSearch() {
                        NavigationLink {
                            RouteSelectionView(
                                fromStation: viewModel.fromStation!,
                                toStation: viewModel.toStation!
                            )
                        } label: {
                            Text("Найти")
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(Color("Blue"))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .font(.system(size: 17, weight: .bold))
                        }
                        .padding(.horizontal, 80.5)
                    }

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
        }
    }
}

#Preview {
    ScheduleView()
}
