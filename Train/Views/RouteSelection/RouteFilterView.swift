//
//  RouteFilterView.swift
//  Train
//

import SwiftUI

struct RouteFilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var filters: RouteFilters
    
    @StateObject private var viewModel: RouteFilterViewModel
    
    init(filters: Binding<RouteFilters>) {
        self._filters = filters
        self._viewModel = StateObject(wrappedValue: RouteFilterViewModel(filters: filters.wrappedValue))
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Время отправления")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color("TextColor"))
                            
                            VStack(spacing: 0) {
                                TimeRangeRow(
                                    title: "Утро 06:00 - 12:00",
                                    isSelected: $viewModel.morningSelected
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TimeRangeRow(
                                    title: "День 12:00 - 18:00",
                                    isSelected: $viewModel.daySelected
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TimeRangeRow(
                                    title: "Вечер 18:00 - 00:00",
                                    isSelected: $viewModel.eveningSelected
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TimeRangeRow(
                                    title: "Ночь 00:00 - 06:00",
                                    isSelected: $viewModel.nightSelected
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
                                    isSelected: viewModel.showTransfers,
                                    onTap: { viewModel.setShowTransfers(true) }
                                )
                                
                                Divider()
                                    .background(Color("TextColor").opacity(0.2))
                                
                                TransferOptionRow(
                                    title: "Нет",
                                    isSelected: !viewModel.showTransfers,
                                    onTap: { viewModel.setShowTransfers(false) }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                }
                
                Button {
                    filters = viewModel.getCurrentFilters()
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
        .navigationTitle("Уточнить время")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color("BackgroundColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color("TextColor"))
                }
            }
        }
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
    NavigationStack {
        RouteFilterView(filters: .constant(RouteFilters()))
    }
}
