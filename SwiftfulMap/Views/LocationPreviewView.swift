//
//  LocationPreviewView.swift
//  SwiftfulMap
//
//  Created by Richard Holland on 13/07/2025.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(.clear)
            .glassEffect(.clear, in: .rect)
            .cornerRadius(10)
            .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
    .environmentObject(LocationsViewModel())
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            
        } label: {
            Text("Learn More")
                .font(.headline)
                .foregroundStyle(Color.white)
                .frame(width: 125, height: 35)
        }
//        .buttonStyle(.borderedProminent)
        .glassEffect(.regular.interactive().tint(.accent.opacity(0.75)))
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPresset()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
//        .buttonStyle(.bordered)
        .glassEffect(.regular.interactive())
    }
}
