//
//  StationSelectionView.swift
//  Train
//

import SwiftUI

struct StationSelectionView: View {
    let city: City
    
    @Binding var selectedCity: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List(city.stations, id: \.self) { station in
            Button {
                selectedCity = "\(city.name) (\(station))"
                dismiss()
                dismiss()
            } label: {
                HStack {
                    Text(station)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(
            city: City(
                name: "Москва",
                stations: [
                    "Курский вокзал",
                    "Казанский вокзал",
                    "Ленинградский вокзал"
                ]
            ),
            selectedCity: .constant("")
        )
    }
}
