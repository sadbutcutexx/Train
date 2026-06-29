//
//  SearchCard.swift
//  Train
//

import SwiftUI

struct SearchCard: View {
    @Binding var fromCity: String
    @Binding var toCity: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 0) {
                NavigationLink {
                    CitySelectionView(selectedCity: $fromCity)
                } label: {
                    HStack {
                        Text(fromCity.isEmpty ? "Откуда" : fromCity)
                            .foregroundStyle(fromCity.isEmpty ? .gray : .black)
                        Spacer()
                    }
                    .padding()
                }
                
                Divider()
                
                NavigationLink {
                    CitySelectionView(selectedCity: $toCity)
                } label: {
                    HStack {
                        Text(toCity.isEmpty ? "Куда" : toCity)
                            .foregroundStyle(fromCity.isEmpty ? .gray : .black)
                        Spacer()
                    }
                    .padding()
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                swap(&fromCity, &toCity)
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
            fromCity: .constant(""),
            toCity: .constant("")
        )
}
