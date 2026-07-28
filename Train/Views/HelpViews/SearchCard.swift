//
//  SearchCard.swift
//  Train
//

import SwiftUI

struct SearchCard: View {
    @Binding var fromStation: SelectedStation?
    @Binding var toStation: SelectedStation?
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 0) {
                NavigationLink {
                    CitySelectionView(selectedStation: $fromStation)
                } label: {
                    HStack {
                        Text(fromStation?.title ?? "Откуда")
                            .foregroundStyle(fromStation == nil ? .gray : .black)
                        Spacer()
                    }
                    .padding()
                }
                
                Divider()
                
                NavigationLink {
                    CitySelectionView(selectedStation: $toStation)
                } label: {
                    HStack {
                        Text(toStation?.title ?? "Куда")
                            .foregroundStyle(toStation == nil ? .gray : .black)
                        Spacer()
                    }
                    .padding()
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                swap(&fromStation, &toStation)
            } label: {
                Image("ChangeButton")
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
        }
        .padding()
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SearchCard(
        fromStation: .constant(nil),
        toStation: .constant(nil)
    )
}
