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
    @Environment(\.managedObjectContext) var moc
    @State var isSavingAllergen : Bool = false;
    
    var body: some View {
        content
            .environmentObject(analysisResultViewModel)
    }
    
    var content: some View {
        
        VStack(alignment: .center){
            
            // If Analysis is exists
            if(analysisResultViewModel.analyzedProductResult.analysis != nil){
                if(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0 > 0) {
                    ScrollView{
                        VStack {
                            // Allergent Result Summary
                            ScanResultSummaryCardComponent(allergentsCount: analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0)
                            
                            // Only showing if there is allergens
                            if(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0 > 0){
                                
                                // Caution Card
                                CautionCard()
                                    .padding(.vertical, 16)
                                
                                // List of Allergents
                                VStack(alignment: .leading) {
                                    Text("Allergent Ingredients List").font(.title3).fontWeight(.medium)
                                        .padding(.bottom, 8)
                                    
                                    VStack{
                                        // For each allergent
                                        ForEach(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.itemList ?? [], id: \.self) { allergen in
                                            AllergenRowComponent(ingredientTableArray: analysisResultViewModel.filterIngredientByAllergent(allergent: allergen))
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                } else {
                    VStack {
                        Spacer()
                        Image("illustration_no_allergen")
                            .padding(.bottom, 8)
                        Text("No allergents have found")
                            .font(.headline)
                            .padding(.bottom, 4)
                        Text("If you experience any adverse reactions to this product, please consult a doctor for information regarding allergens and potential hormonal effects.")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(16)
                    
                }
                
                
                Spacer()
                
                // Bottom Buttons
                VStack{
                    NavigationLink(destination: CameraView()
                        .navigationBarHidden(true)) {
                        Text("Scan Again")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .background(Color.customBrown)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity) // Make NavigationLink full width
                    
//                    NavigationLink(destination: CameraView()
//                        .navigationBarHidden(true)) {
//                        Text("Done")
//                            .font(.headline)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                    }
//                    .foregroundColor(.customBrown)
//                    .cornerRadius(10)
//                    .frame(maxWidth: .infinity) // Make NavigationLink full width
                    
                    Button{
                        analysisResultViewModel.goToCameraView = true
                        if isSavingAllergen {
                            analysisResultViewModel.saveToAllergenCoreData(result: analysisResultViewModel.analyzedProductResult, moc : moc)
                        }
                    } label: {
                        Text("Done")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.darkBrown)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .background{
                    NavigationLink("", destination : CameraView(), isActive: $analysisResultViewModel.goToCameraView)
                }
                .padding(.horizontal, 16)
                
            } else {
                VStack{
                    ProgressView("Loading...")
                        .padding()
                }
            }
            
        }
        .navigationTitle("Scan Result")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if(analysisResultViewModel.analyzedProductResult.analysis == nil){
                if !isSavingAllergen {
                    self.analysisResultViewModel.didAppear(moc : moc)
                } else {
                    self.analysisResultViewModel.isSavingAllergen = true
                    self.analysisResultViewModel.didAppear(moc: moc)
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
