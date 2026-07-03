//
//  RouteCard.swift
//  Train
//

import SwiftUI

struct RouteCard: View {

    let segment: Components.Schemas.Segment

    var body: some View {

        let from = segment.from?.title ?? "—"
        let to = segment.to?.title ?? "—"

        let departure = segment.departure ?? "—"
        let arrival = segment.arrival ?? "—"

        let durationMinutes = (segment.duration ?? 0) / 60

        return VStack(alignment: .leading, spacing: 12) {

            // верх: логотип + перевозчик + дата/пересадки
            HStack(alignment: .top) {

                Image("rzd_logo") // положи в Assets
                    .resizable()
                    .frame(width: 28, height: 28)

                VStack(alignment: .leading, spacing: 4) {
                    Text(segment.thread?.carrier?.title ?? "РЖД")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.black)

                    Text(segment.thread?.title ?? "")
                        .font(.system(size: 12))
                        .foregroundStyle(.red)
                }

                Spacer()

                Text("\(durationMinutes) ч")
                    .font(.system(size: 12))
                    .foregroundStyle(.black.opacity(0.7))
            }

            // середина: маршрут
            HStack(alignment: .center, spacing: 12) {

                Text(departure)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)

                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))

                VStack(spacing: 4) {
                    Text("\(durationMinutes) мин")
                        .font(.system(size: 12))
                        .foregroundStyle(.black.opacity(0.7))

                    Text("→")
                        .font(.system(size: 12))
                        .foregroundStyle(.black.opacity(0.7))
                }

                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))

                Text(arrival)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
            }

            // низ: станции
            HStack {
                Text(from)
                Spacer()
                Text(to)
            }
            .font(.system(size: 12))
            .foregroundStyle(.black.opacity(0.7))
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
}
