//
//  ContentView.swift
//  native_swift_example
//
//  Created by Lucian Burcu on 01.11.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var landmarkRepository = LandmarkRepository()
    
    var body: some View {
        NavigationStack {
            HomeScreen(landmarkRepository: landmarkRepository)
        }
    }

}
