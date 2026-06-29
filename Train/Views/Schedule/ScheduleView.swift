//
//  ScheduleView.swift
//  Train
//

import SwiftUI

struct ScheduleView: View {
    @State private var fromCity = ""
    @State private var toCity = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Black")
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 24) {
                    StoriesView()
                        .padding(.bottom, 44)
                    SearchCard(
                        fromCity: $fromCity,
                        toCity: $toCity
                    )
                    
                    if !fromCity.isEmpty && !toCity.isEmpty {
                        NavigationLink {
                            RouteSelectionView(
                                fromCity: fromCity,
                                toCity: toCity
                            )
                        } label: {
                            Text("Найти")
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(Color("Blue"))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .font(.system(size: 17, weight: .bold))
                                .padding(.leading, 96.5)
                                .padding(.trailing, 96.5)
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
