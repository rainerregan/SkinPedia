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
        NavigationView {
            List{
                Section {
                    ForEach(analysisResultViewModel.analyzedProductResult.analysis?.ingredientsTable ?? [], id: \.self) { ingredient in
                        IngredientRowComponent(ingredient: ingredient)
                    }
                } header: {
                    Text("Ingredients List").font(.headline)
                }
            }
            .navigationTitle("Product Analysis")
            .navigationBarTitleDisplayMode(.large)
            
        }.onAppear {
            self.analysisResultViewModel.didAppear()
        }
    }
}

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}

extension String {

    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
    
}
