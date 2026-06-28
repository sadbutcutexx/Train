//
//  ScheduleView.swift
//  Train
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        ZStack {
            Color("Black")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24) {
                StoriesView()
                    .padding(.bottom, 44)
                SearchCard()
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }
}

#Preview {
    ScheduleView()
}
