//
//  ScheduleView.swift
//  Train
//

import SwiftUI

struct ScheduleView: View {
    @State private var fromStation: SelectedStation?
    @State private var toStation: SelectedStation?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Black")
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 24) {
                    StoriesView()
                        .padding(.bottom, 44)
                    SearchCard(
                        fromStation: $fromStation,
                        toStation: $toStation
                    )
                    
                    if let fromStation, let toStation {
                        NavigationLink {
                            RouteSelectionView(
                                fromStation: fromStation,
                                toStation: toStation
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
