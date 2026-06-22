//
//  ContentView.swift
//  Train
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // testFetchStations()
            // testFetchCopyright()
            // testFetchSchedualBetweenStations()
            // testGetStationSchedule()
            // testFetchRouteStations()
            // testFetchNearestCity()
            // testFetchCarrierInfo()
            testFetchAllStations()
        }
    }
}

#Preview {
    ContentView()
}
