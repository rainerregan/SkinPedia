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
            ForEach(scanViewModel.analyzedProductResult.analysis?.ingredientsTable ?? []) { ingredient in
                VStack {
                    Text(ingredient.title ?? "")
                    Text(ingredient.categories ?? "")
                    Text(ingredient.introtext ?? "")
                }
                
            }

        }
        .onAppear{
            self.scanViewModel.didAppear()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
