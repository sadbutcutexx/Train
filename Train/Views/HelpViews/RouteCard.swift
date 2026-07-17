//
//  RouteCard.swift
//  Train
//

import SwiftUI

struct RouteCard: View {

    let segment: Components.Schemas.Segment

    private var carrierTitle: String {
        segment.thread?.carrier?.title ?? "Перевозчик"
    }

    private var trainTitle: String {
        segment.thread?.title ?? ""
    }
    
    // Each segment represents a direct train journey, so we don't show transfers
    // Transfers would only be relevant if combining multiple segments into a multi-leg journey
    private var transferInfo: String? {
        return nil
    }

    private var departureTime: String {
        guard let departure = segment.departure else { return "—" }
        if let date = ISO8601DateFormatter().date(from: departure) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
        if departure.contains("T") {
            return String(departure.split(separator: "T")[1].prefix(5))
        }
        return departure
    }

    private var arrivalTime: String {
        guard let arrival = segment.arrival else { return "—" }
        if let date = ISO8601DateFormatter().date(from: arrival) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
        if arrival.contains("T") {
            return String(arrival.split(separator: "T")[1].prefix(5))
        }
        return arrival
    }

    private var durationText: String {
        if let departureStr = segment.departure,
           let arrivalStr = segment.arrival,
           let departureDate = ISO8601DateFormatter().date(from: departureStr),
           let arrivalDate = ISO8601DateFormatter().date(from: arrivalStr) {
            
            let durationInSeconds = arrivalDate.timeIntervalSince(departureDate)
            let totalMinutes = Int(durationInSeconds / 60)
            
            let hours = totalMinutes / 60
            let minutes = totalMinutes % 60
            
            if hours > 0 && minutes > 0 {
                return "\(hours) ч \(minutes) мин"
            } else if hours > 0 {
                return "\(hours) ч"
            } else {
                return "\(minutes) мин"
            }
        }
        
        let totalMinutes = segment.duration ?? 0
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours) ч \(minutes) мин"
        } else if hours > 0 {
            return "\(hours) ч"
        } else {
            return "\(minutes) мин"
        }
    }

    private var dateText: String {
        guard let departure = segment.departure else { return "" }
        
        if let date = ISO8601DateFormatter().date(from: departure) {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM"
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter.string(from: date)
        }
        
        return ""
    }

    var body: some View {
        NavigationLink(destination: {
            if let carrier = segment.thread?.carrier {
                CarrierInfoView(carrier: carrier)
            }
        }) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 12) {
                    if let logoURL = segment.thread?.carrier?.logo {
                        AsyncImage(url: URL(string: logoURL)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        } placeholder: {
                            Image(systemName: "train.side.front.car")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.red)
                        }
                    } else {
                        Image(systemName: "train.side.front.car")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.red)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(carrierTitle)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.black)

                        if let transfer = transferInfo {
                            Text(transfer)
                                .font(.system(size: 13))
                                .foregroundStyle(.red)
                        }
                    }

                    Spacer()

                    Text(dateText)
                        .font(.system(size: 15))
                        .foregroundStyle(.black.opacity(0.5))
                }
                .padding(.bottom, 16)

                HStack(alignment: .center, spacing: 0) {
                    Text(departureTime)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.black)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.black.opacity(0.2))
                            .frame(height: 1)
                        
                        Text(durationText)
                            .font(.system(size: 13))
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal, 8)
                            .background(Color("LightGray"))
                    }
                    .padding(.horizontal, 12)
                    
                    Text(arrivalTime)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.black)
                }
            }
            .padding(16)
            .background(Color("LightGray"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
}
