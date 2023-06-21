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
            VStack{
                VStack(alignment: .leading){
                    Text("Summary").font(.headline).padding(.bottom, 8)
                    Text(analysisResultViewModel.analyzedProductResult.analysis?.text?.trimHTMLTags() ?? "")
                }.padding(16)
                
                List{
                    Section {
                        ForEach(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.itemList ?? [], id: \.self) { allergen in
                            AllergenRowComponent(itemList: allergen)
                        }
                    } header: {
                        Text("Allergents List").font(.headline)
                    }
                    
                    Section {
                        ForEach(analysisResultViewModel.analyzedProductResult.analysis?.ingredientsTable ?? [], id: \.self) { ingredient in
                            if(ingredient.alias != nil){
                                IngredientRowComponent(ingredient: ingredient)
                            }
                        }
                    } header: {
                        Text("Ingredients List").font(.headline)
                    }
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
