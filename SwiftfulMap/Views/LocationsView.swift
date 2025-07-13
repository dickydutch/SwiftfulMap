//
//  LocationsView.swift
//  SwiftfulMap
//
//  Created by Richard Holland on 13/07/2025.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(bounds: vm.mapBounds)
//            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
        
                Spacer()
                
                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
//                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .padding(5)
                    .overlay(alignment: .leading) {
                        Image(systemName: vm.showLocationsList ? "arrow.up" : "arrow.down")
                            .contentTransition(.symbolEffect(.replace))
                            .font(.headline)
//                            .foregroundStyle(.primary)
                            .padding()
                    }
            }
            .foregroundStyle(.primary)
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .glassEffect(in: .rect)
        .cornerRadius(10)

    }
    
}
