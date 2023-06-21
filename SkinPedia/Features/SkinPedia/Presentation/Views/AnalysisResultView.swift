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
                
                VStack{
                    VStack(alignment: .leading){
                        Text("Caution!").font(.headline).padding(.bottom, 8)
                        Text("This product contains \(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0) allergens. Please be aware while using this product. Using this product may provoke allergies for some people. For more information, please seek professional advice.")
                    }
                    .padding(16)
                    
                    VStack(alignment: .leading){
                        Text("Summary").font(.headline).padding(.bottom, 8)
                        Text(analysisResultViewModel.analyzedProductResult.analysis?.text?.trimHTMLTags() ?? "")
                    }
                    .padding(16)
                }
                
                
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
