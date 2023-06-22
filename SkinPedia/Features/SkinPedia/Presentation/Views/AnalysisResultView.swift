//
//  AnalysisResultView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//
import SwiftUI
import WrappingHStack

struct AnalysisResultView: View {
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()
    
    var body: some View {
        content
            .environmentObject(analysisResultViewModel)
    }
    
    var content: some View {
        ScrollView{
            VStack(alignment: .leading){
                if(analysisResultViewModel.analyzedProductResult.analysis != nil){
                    ScanResultSummaryCardComponent(allergentsCount: Double(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0), ingredientsCount: Double(analysisResultViewModel.analyzedProductResult.analysis?.ingredientsTable?.count ?? 0))
                    
                    // Only showing if there is allergens
                    if(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0 > 0){
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "lightbulb").foregroundColor(Color.customRed).font(.system(size: 20, weight: .light))
                            
                            Text("Please be aware using this product. Using this product may provoke allergies for some people!").font(.subheadline).foregroundColor(Color.customRed)
                        }.padding(16)
                        
                        VStack(alignment: .leading) {
                            Text("Allergent Ingredients List").font(.title3).fontWeight(.medium)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 8)
                            
                            VStack{
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
                            .padding(.horizontal, 16)
                            
                        }
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Summary of Product").font(.title3).fontWeight(.medium).padding(.bottom, 4)
                        Text(analysisResultViewModel.analyzedProductResult.analysis?.text?.trimHTMLTags()?.split(separator: ":")[0] ?? "").font(.subheadline)
                            .padding(.bottom, 8)
                        
                        WrappingHStack(alignment: .leading){
                            ForEach(analysisResultViewModel.analyzedProductResult.analysis?.text?.trimHTMLTags()?.split(separator: ":")[1].split(separator: ",") ?? [], id:\.self) { item in
                                
                                Text(item.trimmingCharacters(in: .whitespacesAndNewlines))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.mediumBrown)
                                    .cornerRadius(30)
                                    .font(.footnote)
                                    
                            }
                        }
                        
                    }
                    .padding(16)
                    
                    Spacer()
                } else {
                    ProgressView("Loading...")
                        .padding()
                }
                
            }
            .navigationTitle("Scan Result")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.analysisResultViewModel.didAppear()
            }
        }
        
        
    }
}

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}
