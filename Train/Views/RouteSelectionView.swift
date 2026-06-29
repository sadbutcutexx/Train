//
//  RouteSelectionView.swift
//  Train
//

import SwiftUI

struct RouteSelectionView: View {
    
    @Environment(\.dismiss) var dismiss

    let fromCity: String
    let toCity: String

    var body: some View {
        ZStack {
            Color("Black")
                .ignoresSafeArea()

            VStack(alignment: .leading) {

                Text("\(fromCity) → \(toCity)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal)

                // список маршрутов
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
    }
}

#Preview {
    RouteSelectionView(fromCity: "fdf", toCity: "fdg")
}
