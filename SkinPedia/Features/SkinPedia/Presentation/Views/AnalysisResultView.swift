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
        
        VStack(alignment: .center){
            
            // If Analysis is exists
            if(analysisResultViewModel.analyzedProductResult.analysis != nil){
                ScrollView{
                    VStack {
                        // Allergent Result Summary
                        VStack(alignment: .center) {
                            Text("Warning!").font(.title2).fontWeight(.semibold)
                            Text("We have found").font(.body)
                            
                            ZStack{
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 150, height: 150)
                                VStack{
                                    Text("8").font(.title).fontWeight(.semibold)
                                    Text("Allergents")
                                }
                            }
                            
                            Text("From the total ingredients")
                        }
                        .padding(.vertical, 32)
                        
                        // Only showing if there is allergens
                        if(analysisResultViewModel.analyzedProductResult.analysis?.harmful?.allergen?.count ?? 0 > 0){
                            
                            // Caution Card
                            HStack(alignment: .center, spacing: 16) {
                                Image(systemName: "lightbulb.fill").font(.system(size: 20, weight: .light))
                                
                                Text("Please be aware using this product. Using this product may provoke allergies for some people!")
                                    .font(.subheadline)
                            }
                            .padding(16)
                            .background(Color.customRed)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            
                            Spacer().frame(height: 32)
                            
                            // List of Allergents
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
                                }
                                .padding(.horizontal, 16)
                                
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Bottom Buttons
                VStack{
                    NavigationLink(destination: CameraView()) {
                        Text("Scan Again")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .background(Color.darkBrown)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity) // Make NavigationLink full width
                    
                    NavigationLink(destination: CameraView()) {
                        Text("Done")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.darkBrown)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity) // Make NavigationLink full width
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
            self.analysisResultViewModel.didAppear()
            
        }
        
    }
}

struct AnalysisResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisResultView()
    }
}
