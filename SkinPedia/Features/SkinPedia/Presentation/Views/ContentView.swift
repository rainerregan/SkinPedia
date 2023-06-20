//
//  ContentView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 16/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()
    
    var body: some View {
        content
            .environmentObject(analysisResultViewModel)
    }
    
    var content: some View {
        VStack {
            ForEach(analysisResultViewModel.analyzedProductResult.analysis?.ingredientsTable ?? []) { ingredient in
                VStack {
                    Text(ingredient.title ?? "")
                    Text(ingredient.categories ?? "")
                    Text(ingredient.introtext ?? "")
                }
                
            }

        }
        .onAppear{
            self.analysisResultViewModel.didAppear()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
