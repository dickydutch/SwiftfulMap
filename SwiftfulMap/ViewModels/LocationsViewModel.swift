//
//  LocationsViewModel.swift
//  SwiftfulMap
//
//  Created by Richard Holland on 13/07/2025.
//

import Foundation
import Combine
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current Location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    
//    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
//    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var mapBounds: MapCameraBounds = MapCameraBounds()
    @Published var mapPosition: MapCameraPosition = .camera(.init(centerCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), distance: 1))
    
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: mapLocation)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            //            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
            let rect = MKMapRect(origin: MKMapPoint(location.coordinates), size: MKMapSize(width: 1, height: 1))
            mapBounds = MapCameraBounds(centerCoordinateBounds: rect, minimumDistance: 1000, maximumDistance: 80000)
            mapPosition = .camera(.init(centerCoordinate: location.coordinates, distance: 10000))
        }

    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPresset() {
        // Get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array. Should never happen!")
            return
        }
        
        // Check if current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid, restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        // Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
}
