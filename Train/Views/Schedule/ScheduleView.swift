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
