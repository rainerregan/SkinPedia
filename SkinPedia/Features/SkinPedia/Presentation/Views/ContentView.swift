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
            Text(scanViewModel.analyzedProductResult.analysis?.ingredientsTable?.debugDescription ?? "")
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
