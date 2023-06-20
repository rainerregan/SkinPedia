//
//  AnalysisResultView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import SwiftUI

struct AnalysisResultView: View {
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()
    
    var body: some View {
        content
            .environmentObject(analysisResultViewModel)
    }
    
    var content: some View {
        NavigationStack {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        print("back")
                    } label: {
                        Label("Back" ,systemImage: "chevron.left")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Product Scan Analysis")
                        .fontWeight(.medium)
                }
            }
            
        }
    }
}

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}
