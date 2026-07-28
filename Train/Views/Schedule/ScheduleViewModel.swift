//
//  ScheduleViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class ScheduleViewModel: ObservableObject {
    
    @Published var fromStation: SelectedStation?
    @Published var toStation: SelectedStation?
    @Published var isLoading: Bool = false
    
    func swapStations() {
        swap(&fromStation, &toStation)
    }
    
    func canSearch() -> Bool {
        return fromStation != nil && toStation != nil
    }
    
    func clearFromStation() {
        fromStation = nil
    }
    
    func clearToStation() {
        toStation = nil
    }
}
