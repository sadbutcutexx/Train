//
//  RouteFilterView.swift
//  Train
//

import SwiftUI

struct RouteFilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var filters: RouteFilters
    
    @State private var morningSelected: Bool
    @State private var daySelected: Bool
    @State private var eveningSelected: Bool
    @State private var nightSelected: Bool
    @State private var showTransfers: Bool
    
    init(filters: Binding<RouteFilters>) {
        self._filters = filters
        self._morningSelected = State(initialValue: filters.wrappedValue.morningSelected)
        self._daySelected = State(initialValue: filters.wrappedValue.daySelected)
        self._eveningSelected = State(initialValue: filters.wrappedValue.eveningSelected)
        self._nightSelected = State(initialValue: filters.wrappedValue.nightSelected)
        self._showTransfers = State(initialValue: filters.wrappedValue.showTransfers)
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("TextColor"))
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Время отправления")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color("TextColor"))
                            
                            VStack(spacing: 0) {
                                TimeRangeRow(
                                    title: "Утро 06:00 - 12:00",
                                    isSelected: $morningSelected
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TimeRangeRow(
                                    title: "День 12:00 - 18:00",
                                    isSelected: $daySelected
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TimeRangeRow(
                                    title: "Вечер 18:00 - 00:00",
                                    isSelected: $eveningSelected
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TimeRangeRow(
                                    title: "Ночь 00:00 - 06:00",
                                    isSelected: $nightSelected
                                )
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Показывать варианты с пересадками")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color("TextColor"))
                            
                            VStack(spacing: 0) {
                                TransferOptionRow(
                                    title: "Да",
                                    isSelected: showTransfers,
                                    onTap: { showTransfers = true }
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TransferOptionRow(
                                    title: "Нет",
                                    isSelected: !showTransfers,
                                    onTap: { showTransfers = false }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                }
                
                Button {
                    filters = RouteFilters(
                        morningSelected: morningSelected,
                        daySelected: daySelected,
                        eveningSelected: eveningSelected,
                        nightSelected: nightSelected,
                        showTransfers: showTransfers
                    )
                    dismiss()
                } label: {
                    Text("Применить")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color("BackgroundColor"))
            }
        }
        .presentationBackground(Color("BackgroundColor"))
    }
}

struct TimeRangeRow: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color("TextColor"))
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? .blue : Color("TextColor"))
            }
            .padding(.vertical, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct TransferOptionRow: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color("TextColor"))
                
                Spacer()
                
                Image(systemName: isSelected ? "circle.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? .blue : Color("TextColor"))
            }
            .padding(.vertical, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct RouteFilters {
    var morningSelected: Bool = true
    var daySelected: Bool = true
    var eveningSelected: Bool = true
    var nightSelected: Bool = true
    var showTransfers: Bool = false
}

#Preview {
    RouteFilterView(filters: .constant(RouteFilters()))
}
