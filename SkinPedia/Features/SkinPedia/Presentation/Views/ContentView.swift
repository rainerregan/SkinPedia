//
//  ContentView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 16/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var scanViewModel = ScanViewModel()
    
    var body: some View {
        content
            .environmentObject(scanViewModel)
    }
    
    var content: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(scanViewModel.analyzedProductResult.analysis.debugDescription)
        }
        .padding()
        .onAppear {
            self.scanViewModel.didAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
