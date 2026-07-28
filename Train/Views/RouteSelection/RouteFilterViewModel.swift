//
//  RouteFilterViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class RouteFilterViewModel: ObservableObject {
    
    @Published var morningSelected: Bool
    @Published var daySelected: Bool
    @Published var eveningSelected: Bool
    @Published var nightSelected: Bool
    @Published var showTransfers: Bool
    
    private let originalFilters: RouteFilters
    
    init(filters: RouteFilters) {
        self.originalFilters = filters
        self.morningSelected = filters.morningSelected
        self.daySelected = filters.daySelected
        self.eveningSelected = filters.eveningSelected
        self.nightSelected = filters.nightSelected
        self.showTransfers = filters.showTransfers
    }
    
    func toggleMorning() {
        morningSelected.toggle()
    }
    
    func toggleDay() {
        daySelected.toggle()
    }
    
    func toggleEvening() {
        eveningSelected.toggle()
    }
    
    func toggleNight() {
        nightSelected.toggle()
    }
    
    func setShowTransfers(_ value: Bool) {
        showTransfers = value
    }
    
    func getCurrentFilters() -> RouteFilters {
        return RouteFilters(
            morningSelected: morningSelected,
            daySelected: daySelected,
            eveningSelected: eveningSelected,
            nightSelected: nightSelected,
            showTransfers: showTransfers
        )
    }
    
    func hasChanges() -> Bool {
        let current = getCurrentFilters()
        return current.morningSelected != originalFilters.morningSelected ||
               current.daySelected != originalFilters.daySelected ||
               current.eveningSelected != originalFilters.eveningSelected ||
               current.nightSelected != originalFilters.nightSelected ||
               current.showTransfers != originalFilters.showTransfers
    }
    
    func resetToDefaults() {
        morningSelected = true
        daySelected = true
        eveningSelected = true
        nightSelected = true
        showTransfers = false
    }
    
    func isAnyTimeSelected() -> Bool {
        return morningSelected || daySelected || eveningSelected || nightSelected
    }
}
