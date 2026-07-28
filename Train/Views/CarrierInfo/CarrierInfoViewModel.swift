//
//  CarrierInfoViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    
    @Published var carrier: Components.Schemas.Carrier
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let service: CarrierInfoServiceProtocol?
    
    init(carrier: Components.Schemas.Carrier, service: CarrierInfoServiceProtocol? = nil) {
        self.carrier = carrier
        self.service = service
    }
    
    var displayTitle: String {
        carrier.title ?? "Перевозчик"
    }
    
    var displayEmail: String? {
        carrier.email
    }
    
    var displayPhone: String? {
        carrier.phone
    }
    
    var displayLogo: String? {
        carrier.logo
    }
    
    var hasContactInfo: Bool {
        displayEmail != nil || displayPhone != nil
    }
}
