//
//  ContentView.swift
//  MapKit in Swift UI
//
//  Created by Oriakhi Collins on 4/3/22.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @StateObject private var  viewModel = ContentViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkLocationServiceEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



