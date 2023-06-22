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
        VStack(alignment: .leading){
            
            ScanResultSummaryCardComponent(allergentsCount: Double(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0), ingredientsCount: Double(analysisResultViewModel.analyzedProductResult.analysis?.ingredientsTable?.count ?? 0))
            
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: "lightbulb").foregroundColor(Color.customRed).font(.system(size: 20, weight: .light))
                Text("Please be aware using this product. Using this product may provoke allergies for some people!").font(.subheadline).foregroundColor(Color.customRed)
            }.padding(16)
            
            VStack(alignment: .leading) {
                Text("Allergent Ingredients List").font(.title3).fontWeight(.medium)
                    .padding(.horizontal, 16)
                
                List{
                    ForEach(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.itemList ?? [], id: \.self) { allergen in
                        // TODO: Navigate to Detail Page
                        NavigationLink(destination: SampleFormView()){
                            AllergenRowComponent(itemList: allergen)
                        }
                    }
                    
//                    ForEach(analysisResultViewModel.analyzedProductResult.analysis?.ingredientsTable ?? [], id: \.self) { ingredient in
//                                if(ingredient.alias != nil){
//                                    IngredientRowComponent(ingredient: ingredient)
//                                }
//                        NavigationLink(destination: SampleFormView()){
//                            IngredientRowComponent(ingredient: ingredient)
//                        }
//                    }
                }
                .listStyle(.plain)
                
            }
            
            Spacer()
            
        }
        .navigationTitle("Scan Result")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.analysisResultViewModel.didAppear()
        }
    }
}

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}
